//
//  NewNOCViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 11/26/14.
//  Copyright (c) 2014 Zapp. All rights reserved.
//

#import "NewNOCViewController.h"
#import "SFRestAPI+Blocks.h"
#import "EServiceAdministration.h"
#import "EServiceDocument.h"
#import "WebForm.h"
#import "FormField.h"
#import "HelperClass.h"
#import "AttachmentsViewController.h"
#import "NOCReviewViewController.h"

@interface NewNOCViewController ()

@end

@implementation NewNOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"New NOC";
    
    [self getNOCTypes];
    [self getNOCRecordType];
    [self getAramexRates];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseNOCButtonClicked:(id)sender {
    NSMutableArray* stringArray = [[NSMutableArray alloc] init];
    
    for (EServiceAdministration *eServiceObject in self.dataRows) {
        [stringArray addObject:eServiceObject.serviceIdentifier];
    }
    
    SFPickListViewController *pickListViewController = [SFPickListViewController createPickListViewController:stringArray selectedValue:self.chooseNOCButton.titleLabel.text];
    
    pickListViewController.delegate = self;
    pickListViewController.preferredContentSize = CGSizeMake(320, stringArray.count * 44);
    
    self.chooseNOCPopover = [[UIPopoverController alloc] initWithContentViewController:pickListViewController];
    
    self.chooseNOCPopover.delegate = self;
    
    UIButton *senderButton = (UIButton*)sender;
    
    [self.chooseNOCPopover presentPopoverFromRect:senderButton.frame inView:senderButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)submitButtonClicked:(id)sender {
    [self createCaseRecord];
}

- (IBAction)attachmentsButtonClicked:(id)sender {
    AttachmentsViewController *attachmentVC = [AttachmentsViewController new];
    attachmentVC.attachmentsNamesArray = selectedServiceAdmin.serviceDocumentsArray;
    attachmentVC.containerViewController = self;
    
    self.attachmentsPopover = [[UIPopoverController alloc] initWithContentViewController:attachmentVC];
    self.attachmentsPopover.popoverContentSize = attachmentVC.view.frame.size;
    
    self.attachmentsPopover.delegate = self;
    
    CGRect rect = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 1, 1);
    
    [self.attachmentsPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:0 animated:YES];
}

- (void)createNOCRecord:(NSString*)caseId {
    NSMutableDictionary *fields = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.employeeId, @"Person__c",
                                   self.accountId, @"Current_Sponsor__c",
                                   self.visaId, @"Current_Visa__c",
                                   @"Application Received", @"Application_Status__c",
                                   self.nocNameSelected, @"Document_Name__c",
                                   underProcessRecordTypeId, @"RecordTypeId",
                                   [NSNumber numberWithBool:[self.courierSwitch isOn]], @"isCourierRequired__c",
                                   caseId, @"Request__c",
                                   nil];
    
    for (FormField *formField in currentWebForm.formFields) {
        if(!formField.isCalculated)
            [fields setValue:[formField getFormFieldValue] forKey:formField.name];
    }
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        insertedNOCId = [dict objectForKey:@"id"];
        [HelperClass createCompanyDocuments:insertedNOCId ParentField:@"NOC__c" Document:selectedServiceAdmin.serviceDocumentsArray CompanyID:self.accountId];
        
        [self updateCaseObject:caseId NOC:insertedNOCId Invoice:@""];
        
        //[self getCustomerTransaction:caseId NOC:insertedNOCId];
        
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    [[SFRestAPI sharedInstance] performCreateWithObjectType:@"NOC__c"
                                                     fields:fields
                                                  failBlock:errorBlock
                                              completeBlock:successBlock];
}

- (void)createCaseRecord {
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:[self.courierSwitch isOn]] ,@"isCourierRequired__c",
                            self.courierCorpRateTextView.text, @"Courier_Corporate_Fee__c",
                            self.courierRetailRateTextView.text, @"Courier_Retail_Fee__c",
                            self.nocIDSeleted ,@"Service_Requested__c",
                            self.employeeId, @"Employee_Ref__c",
                            self.accountId, @"AccountId",
                            NOCRecordTypeId, @"RecordTypeId",
                            @"Draft", @"Status",
                            @"NOC Services", @"Type",
                            @"Mobile", @"Origin",
                            nil];
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        insertedCaseId = [dict objectForKey:@"id"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createNOCRecord:insertedCaseId];
        });
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    [[SFRestAPI sharedInstance] performCreateWithObjectType:@"Case"
                                                     fields:fields
                                                  failBlock:errorBlock
                                              completeBlock:successBlock];
}

- (void)getCustomerTransaction:(NSString*)caseId NOC:(NSString*)nocID {
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *records = [dict objectForKey:@"records"];
        NSLog(@"request:didLoadResponse: #records: %d", records.count);
        
        self.dataRows = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in records) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateCaseObject:caseId NOC:nocID Invoice:[dict objectForKey:@"Invoice__c"]];
                [self updateAccountBalance];
            });
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
    };
    
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT ID, Name, Invoice__c FROM Free_Zone_Payment__c WHERE Request__c = '%@' AND NOC__c = '%@' AND Free_Zone_Customer__c = '%@' LIMIT 1", caseId, nocID, self.accountId];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

- (void)updateCaseObject:(NSString*)caseId NOC:(NSString*)nocId Invoice:(NSString*)invoiceId {
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            /*invoiceId, @"Invoice__c",*/
                            nocId, @"Noc__c",
                            /*@"Application Submitted", @"Status",*/
                            nil];
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NOCReviewViewController *nocReviewVC = [NOCReviewViewController new];
            
            nocReviewVC.caseId = insertedCaseId;
            nocReviewVC.currentWebForm = currentWebForm;
            
            [self.navigationController pushViewController:nocReviewVC animated:YES];
        });
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
    };
    
    [[SFRestAPI sharedInstance] performUpdateWithObjectType:@"Case"
                                                   objectId:caseId
                                                     fields:fields
                                                  failBlock:errorBlock
                                              completeBlock:successBlock];
}

- (void)updateAccountBalance {
    NSNumber *newBalance = [NSNumber numberWithFloat:([self.accountBalance floatValue] - [selectedServiceAdmin.amount floatValue])];
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            newBalance, @"Account_Balance__c",
                            nil];
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"Case inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
    };
    
    [[SFRestAPI sharedInstance] performUpdateWithObjectType:@"Account"
                                                   objectId:self.accountId
                                                     fields:fields
                                                  failBlock:errorBlock
                                              completeBlock:successBlock];
    
}

- (void)getAramexRates {
    
    // Manually set up request object
    SFRestRequest *aramexRequest = [[SFRestRequest alloc] init];
    aramexRequest.endpoint = [NSString stringWithFormat:@"/services/apexrest/MobileAramexRateWebService"];
    aramexRequest.method = SFRestMethodGET;
    //aramexRequest.path = @"/services/apexrest/MobileAramexRateWebService";
    aramexRequest.path = [NSString stringWithFormat:@"/services/apexrest/MobileAramexRateWebService?city=%@&country=%@", self.billingCity, self.billingCountry];
    
    [[SFRestAPI sharedInstance] send:aramexRequest delegate:self];
}

- (void)getNOCTypes {
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *records = [dict objectForKey:@"records"];
        NSLog(@"request:didLoadResponse: #records: %d", records.count);
        
        self.dataRows = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in records) {
            NSArray *documentRecordsArray = [NSArray new];
            if(![[dict objectForKey:@"eServices_Document_Checklists__r"] isKindOfClass:[NSNull class]])
                documentRecordsArray = [[dict objectForKey:@"eServices_Document_Checklists__r"] objectForKey:@"records"];
            
            [self.dataRows addObject:[[EServiceAdministration alloc]
                                      initEServiceAdministration:[dict objectForKey:@"Id"]
                                      Name:[dict objectForKey:@"Name"]
                                      ServiceIdentifier:[dict objectForKey:@"Service_Identifier__c"]
                                      Amount:[dict objectForKey:@"Amount__c"]
                                      RelatedToObject:[dict objectForKey:@"Related_to_Object__c"]
                                      VisualForceGenerator:[dict objectForKey:@"New_Edit_VF_Generator__c"]
                                      ServiceDocumentsArray:documentRecordsArray]];
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = @"SELECT ID, Name, Service_Identifier__c, Amount__c, Related_to_Object__c, New_Edit_VF_Generator__c, (SELECT ID, Name, Type__c, Language__c, Document_Type__c FROM eServices_Document_Checklists__r WHERE Document_Type__c = 'Upload') FROM Receipt_Template__c WHERE Related_to_Object__c INCLUDES ('NOC') AND Redirect_Page__c != null AND RecordType.DeveloperName = 'Auto_Generated_Invoice' AND Is_Active__c = true ORDER BY Service_Identifier__c";
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

- (void)getNOCRecordType {
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *recordTypesArray = [dict objectForKey:@"records"];
        for (NSDictionary *obj in recordTypesArray) {
            NSString *objectType = [obj objectForKey:@"SobjectType"];
            NSString *developerName = [obj objectForKey:@"DeveloperName"];
            
            if([objectType isEqualToString:@"Case"] && [developerName isEqualToString:@"NOC_Request"])
                NOCRecordTypeId = [obj objectForKey:@"Id"];
            
            if([objectType isEqualToString:@"NOC__c"] && [developerName isEqualToString:@"Under_Process"])
                underProcessRecordTypeId = [obj objectForKey:@"Id"];
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = @"SELECT Id, Name, DeveloperName, SobjectType FROM RecordType WHERE (SobjectType = 'Case' AND DeveloperName = 'NOC_Request') OR (SObjectType = 'NOC__c' AND DeveloperName = 'Under_Process')";
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

- (void)getWebForm:(NSString*)Id {
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *records = [dict objectForKey:@"records"];
        
        for (NSDictionary *dict in records) {
            currentWebForm = [[WebForm alloc] initWebForm:[dict objectForKey:@"Id"]
                                                     Name:[dict objectForKey:@"Name"]
                                              Description:[dict objectForKey:@"Description__c"]
                                                    Title:[dict objectForKey:@"Title__c"]
                                       IsNotesAttachments:[[dict objectForKey:@"isNotesAttachments__c"] boolValue]
                                              ObjectLabel:[dict objectForKey:@"Object_Label__c"]
                                               ObjectName:[dict objectForKey:@"Object_Name__c"]];
            NSMutableArray *fieldsArray = [[NSMutableArray alloc] init];
            
            NSDictionary *fieldsJSONArray = [[dict objectForKey:@"R00N70000002DiOrEAK__r"] objectForKey:@"records"];
            for (NSDictionary *fieldsDict in fieldsJSONArray) {
                if([[fieldsDict objectForKey:@"Type__c"] isEqualToString:@"CUSTOMTEXT"])
                    continue;
                
                [fieldsArray addObject:[[FormField alloc] initFormField:[fieldsDict objectForKey:@"Id"]
                                                                   Name:[fieldsDict objectForKey:@"Name"]
                                                            APIRequired:[[fieldsDict objectForKey:@"APIRequired__c"] boolValue]
                                                           BooleanValue:[[fieldsDict objectForKey:@"Boolean_Value__c"] boolValue]
                                                          CurrencyValue:[fieldsDict objectForKey:@"Currency_Value__c"]
                                                          DateTimeValue:[fieldsDict objectForKey:@"DateTime_Value__c"]
                                                              DateValue:[fieldsDict objectForKey:@"Date_Value__c"]
                                                             EmailValue:[fieldsDict objectForKey:@"Email_Value__c"]
                                                                 Hidden:[[fieldsDict objectForKey:@"Hidden__c"] boolValue]
                                                           IsCalculated:[[fieldsDict objectForKey:@"isCalculated__c"] boolValue]
                                                            IsParameter:[[fieldsDict objectForKey:@"isParameter__c"] boolValue]
                                                                IsQuery:[[fieldsDict objectForKey:@"isQuery__c"] boolValue]
                                                                  Label:[fieldsDict objectForKey:@"Label__c"]
                                                            NumberValue:[fieldsDict objectForKey:@"Number_Value__c"]
                                                                  Order:[fieldsDict objectForKey:@"Order__c"]
                                                           PercentValue:[fieldsDict objectForKey:@"Percent_Value__c"]
                                                             PhoneValue:[fieldsDict objectForKey:@"Phone_Value__c"]
                                                          PicklistValue:[fieldsDict objectForKey:@"Picklist_Value__c"]
                                                        PicklistEntries:[fieldsDict objectForKey:@"PicklistEntries__c"]
                                                               Required:[[fieldsDict objectForKey:@"Required__c"] boolValue]
                                                      TextAreaLongValue:[fieldsDict objectForKey:@"Text_Area_Long_Value__c"]
                                                          TextAreaValue:[fieldsDict objectForKey:@"Text_Area_Value__c"]
                                                              TextValue:[fieldsDict objectForKey:@"Text_Value__c"]
                                                                   Type:[fieldsDict objectForKey:@"Type__c"]
                                                               UrlValue:[fieldsDict objectForKey:@"URL_Value__c"]
                                                                WebForm:[fieldsDict objectForKey:@"Web_Form__c"]
                                                                  Width:[fieldsDict objectForKey:@"Width__c"]
                                                      IsMobileAvailable:[[fieldsDict objectForKey:@"isMobileAvailable__c"] boolValue]
                                                            MobileLabel:[fieldsDict objectForKey:@"Mobile_Label__c"]
                                                            MobileOrder:[fieldsDict objectForKey:@"Mobile_Order__c"]]];
            }
            
            currentWebForm.formFields = [NSArray arrayWithArray:fieldsArray];
            
            [self getFormFieldsValues];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self getFormFieldsValues];
            });
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT Id, Name, Description__c, Title__c, isNotesAttachments__c, Object_Label__c, Object_Name__c, (SELECT Id, Name, APIRequired__c, Boolean_Value__c, Currency_Value__c, DateTime_Value__c, Date_Value__c, Email_Value__c , Hidden__c, isCalculated__c, isParameter__c, isQuery__c, Label__c, Number_Value__c, Order__c, Percent_Value__c, Phone_Value__c, Picklist_Value__c, PicklistEntries__c, Required__c, Text_Area_Long_Value__c, Text_Area_Value__c, Text_Value__c, Type__c, URL_Value__c, Web_Form__c, Width__c, isMobileAvailable__c, Mobile_Label__c, Mobile_Order__c  FROM R00N70000002DiOrEAK WHERE isMobileAvailable__c = true ORDER BY Mobile_Order__c) FROM Web_Form__c WHERE ID = '%@'", Id];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
    
}

- (void)getFormFieldsValues {
    
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *records = [dict objectForKey:@"records"];
        
        if(records.count <= 0)
            return;
        
        NSDictionary *visaObject = [records objectAtIndex:0];
        
        for (FormField *formField in currentWebForm.formFields) {
            if(!formField.isQuery)
                continue;
            
            [formField setFormFieldValue:[HelperClass getRelationshipValue:visaObject Key:formField.textValue]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HelperClass drawFormFields:currentWebForm DynamicView:self.dynamicView];
        });
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSMutableString *selectQuery = [NSMutableString stringWithString:@"SELECT Id"];
    
    for (FormField *formField in currentWebForm.formFields) {
        if(!formField.isQuery)
            continue;
        
        [selectQuery appendFormat:@", %@", formField.textValue];
    }
    
    [selectQuery appendFormat:@" FROM Visa__c WHERE ID = '%@' LIMIT 1", self.visaId];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
    
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    NSLog(@"request:didLoadResponse: %@", dict);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.courierCorpRateTextView setText:[dict objectForKey:@"amount"]];
        [self.courierRetailRateTextView setText:[dict objectForKey:@"retailAmount"]];
    });
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}

#pragma UIPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}

#pragma SFPickListViewDelegate
- (void)valuePickCanceled:(SFPickListViewController *)picklist {
    
}

- (void)valuePicked:(NSString *)value pickList:(SFPickListViewController *)picklist {
    
    if ([self.chooseNOCPopover isPopoverVisible]) {
        [self.chooseNOCButton setTitle:value forState:UIControlStateNormal];
        [self.chooseNOCPopover dismissPopoverAnimated:YES];
        
        for (EServiceAdministration *eServiceObject in self.dataRows) {
            if([value isEqualToString:eServiceObject.serviceIdentifier]) {
                self.nocIDSeleted = eServiceObject.Id;
                self.nocNameSelected = value;
                
                selectedServiceAdmin = eServiceObject;
                
                NSString *amount = [eServiceObject.amount stringValue];
                
                [self.nocChargesTextField setText:amount];
                
                [HelperClass removeFormFields:self.dynamicView];
                
                [self getWebForm:eServiceObject.visualForceGenerator];
                
                [self.attachmentsButton setHidden:[selectedServiceAdmin.serviceDocumentsArray count] <= 0];
            }
        }
        
    }
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
