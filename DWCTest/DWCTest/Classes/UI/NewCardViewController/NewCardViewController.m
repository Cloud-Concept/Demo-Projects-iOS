//
//  NewCardViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "NewCardViewController.h"
#import "SFRestAPI+Blocks.h"
#import "WebForm.h"
#import "FormField.h"
#import "HelperClass.h"
#import "EServiceDocument.h"
#import "AttachmentsViewController.h"
#import "NewCardReviewViewController.h"

@interface NewCardViewController ()

@end

@implementation NewCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //co-ordinate system of iOS 6 & iOS 7 are different iOS 7
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout = NO;
    }
    
    
    // Do any additional setup after loading the view from its nib.
    cardTypesDescriptionsArray = @[@"New FM Contractor Pass", @"New Contractor Pass", @"New Work Permit Pass", @"New Access Card", @"Replacement of Lost Employment Card"];
    cardTypesValuesArray = @[@"FM_Contractor_Card", @"Contractor_Card", @"Work_Permit_Card", @"Access_Card", @"Employment_Card"];
    
    [self getCardRecordType];
    
    if (self.operationType != nil && ![self.operationType isEqualToString:@""]) {
        [self getServiceAdministrator];
        [self.selectCardTypeButton setTitle:self.selectedCardType forState:UIControlStateNormal];
        [self.selectDurationButton setTitle:self.selectedDuration forState:UIControlStateNormal];
    }
    else {
        self.selectedCardType = @"";
        self.selectedDuration = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCardTypeButtonClicked:(id)sender {
    SFPickListViewController *pickListViewController = [SFPickListViewController createPickListViewController:cardTypesDescriptionsArray selectedValue:self.selectedCardType];
    
    pickListViewController.delegate = self;
    pickListViewController.preferredContentSize = CGSizeMake(320, cardTypesDescriptionsArray.count * 44);
    
    self.selectCardTypePopover = [[UIPopoverController alloc] initWithContentViewController:pickListViewController];
    
    self.selectCardTypePopover.delegate = self;
    
    UIButton *senderButton = (UIButton*)sender;
    
    [self.selectCardTypePopover presentPopoverFromRect:senderButton.frame inView:senderButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)selectDurationButtonClicked:(id)sender {
    durationArray = [NSMutableArray new];
    
    if (![self.selectedCardType isEqualToString:@""]) {
        if ([self.selectedCardType isEqualToString:@"Access_Card"])
            [durationArray addObject:@"1 Day"];
        
        if ([self.selectedCardType isEqualToString:@"Contractor_Card"])
            [durationArray addObject:@"1 Week"];
        
        [durationArray addObject:@"1 Month"];
        
        if ([self.selectedCardType isEqualToString:@"Contractor_Card"])
            [durationArray addObject:@"2 Months"];
        
        [durationArray addObject:@"3 Months"];
        
        if ([self.selectedCardType isEqualToString:@"Contractor_Card"]) {
            [durationArray addObject:@"4 Months"];
            [durationArray addObject:@"5 Months"];
        }
        
        [durationArray addObject:@"6 Months"];
        [durationArray addObject:@"1 Year"];
    }
    
    
    SFPickListViewController *pickListViewController = [SFPickListViewController createPickListViewController:durationArray selectedValue:self.selectedDuration];
    
    pickListViewController.delegate = self;
    pickListViewController.preferredContentSize = CGSizeMake(320, durationArray.count * 44);
    
    self.selectDurationPopover = [[UIPopoverController alloc] initWithContentViewController:pickListViewController];
    
    self.selectDurationPopover.delegate = self;
    
    UIButton *senderButton = (UIButton*)sender;
    
    [self.selectDurationPopover presentPopoverFromRect:senderButton.frame inView:senderButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)submitButtonClicked:(id)sender {
    if ([self validateInput]) {
        [self createCaseRecord];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"Fill all required fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alert show];
    }
    
}

- (IBAction)attachmentButtonClicked:(id)sender {
    AttachmentsViewController *attachmentVC = [AttachmentsViewController new];
    attachmentVC.attachmentsNamesArray = documentsArray;
    attachmentVC.containerViewController = self;
    
    self.attachmentsPopover = [[UIPopoverController alloc] initWithContentViewController:attachmentVC];
    self.attachmentsPopover.popoverContentSize = attachmentVC.view.frame.size;
    
    self.attachmentsPopover.delegate = self;
    
    CGRect rect = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 1, 1);
    
    [self.attachmentsPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:0 animated:YES];
}

- (BOOL)validateInput {
    BOOL returnValue = YES;
    for (FormField *formField in currentWebForm.formFields) {
        if(formField.required && [[formField getFormFieldValue] isEqualToString:@""])
            returnValue = NO;
    }
    
    return returnValue;
}

- (void)resetValues {
    self.selectedCardType = @"";
    self.selectedDuration = @"";
    selectedCardManagementRecordType = @"";
    selectedServiceID = @"";
    
    currentWebForm = nil;
    
    documentsArray = [NSArray new];
    
    [self.selectDurationButton setTitle:@"Select Duration" forState:UIControlStateNormal];
    [self.selectCardTypeButton setTitle:@"Select Card Type" forState:UIControlStateNormal];
    [self.feesTextView setText:@""];
    
    [HelperClass removeFormFields:self.dynamicView];
}

- (void)getServiceAdministrator {
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        NSArray *records = [dict objectForKey:@"records"];
        
        NSNumber *amount;
        NSString *newEditVFGenerator = @"";
        NSString *cancelVFGenerator = @"";
        NSString *renewalVFGenerator = @"";
        NSString *replaceVFGenerator = @"";
        
        for (NSDictionary *dict in records) {
            selectedServiceID = [dict objectForKey:@"Id"];
            amount = [dict objectForKey:@"Amount__c"];
            newEditVFGenerator = [dict objectForKey:@"New_Edit_VF_Generator__c"];
            cancelVFGenerator = [dict objectForKey:@"Cancel_VF_Generator__c"];
            renewalVFGenerator = [dict objectForKey:@"Renewal_VF_Generator__c"];
            replaceVFGenerator = [dict objectForKey:@"Replace_VF_Generator__c"];
            
            selectedCardManagementRecordType = [dict objectForKey:@"Record_Type_Picklist__c"];
            
            NSMutableArray *documentsMutableArray = [NSMutableArray new];
            if(![[dict objectForKey:@"eServices_Document_Checklists__r"] isKindOfClass:[NSNull class]])
                for(NSDictionary *documentObj in [[dict objectForKey:@"eServices_Document_Checklists__r"] objectForKey:@"records"]) {
                    EServiceDocument *newDocument = [[EServiceDocument alloc] initEServiceDocument:[documentObj objectForKey:@"Id"]
                                                                                              Name:[documentObj objectForKey:@"Name"]
                                                                                              Type:[documentObj objectForKey:@"Type__c"]
                                                                                          Language:[documentObj objectForKey:@"Language__c"]
                                                                                      DocumentType:[documentObj objectForKey:@"Document_Type__c"]];
                    [documentsMutableArray addObject:newDocument];
                }
            documentsArray = [NSArray arrayWithArray:documentsMutableArray];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.operationType isEqualToString:@"RenewCard"])
                [self getWebForm:renewalVFGenerator];
            else if ([self.operationType isEqualToString:@"CancelCard"])
                [self getWebForm:cancelVFGenerator];
            else if ([self.operationType isEqualToString:@"ReplaceCard"])
                [self getWebForm:replaceVFGenerator];
            else
                [self getWebForm:newEditVFGenerator];
            
            
            [self.feesTextView setText:[amount stringValue]];
            [self.attachmentsButton setHidden:[documentsArray count] <= 0];
        });
        
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT Id, New_Edit_VF_Generator__c, Cancel_VF_Generator__c, Renewal_VF_Generator__c, Replace_VF_Generator__c, Amount__c, Record_Type_Picklist__c, (SELECT ID, Name, Type__c, Language__c, Document_Type__c FROM eServices_Document_Checklists__r WHERE Document_Type__c = 'Upload') FROM Receipt_Template__c WHERE Duration__c = '%@' AND Record_Type_Picklist__c = '%@'", self.selectedDuration, self.selectedCardType];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
    
}

- (void)getWebForm:(NSString*)vfGeneratorId {
    
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
            
            //[self getFormFieldsValues];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HelperClass drawFormFields:currentWebForm DynamicView:self.dynamicView];
            });
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT Id, Name, Description__c, Title__c, isNotesAttachments__c, Object_Label__c, Object_Name__c, (SELECT Id, Name, APIRequired__c, Boolean_Value__c, Currency_Value__c, DateTime_Value__c, Date_Value__c, Email_Value__c , Hidden__c, isCalculated__c, isParameter__c, isQuery__c, Label__c, Number_Value__c, Order__c, Percent_Value__c, Phone_Value__c, Picklist_Value__c, PicklistEntries__c, Required__c, Text_Area_Long_Value__c, Text_Area_Value__c, Text_Value__c, Type__c, URL_Value__c, Web_Form__c, Width__c, isMobileAvailable__c, Mobile_Label__c, Mobile_Order__c  FROM R00N70000002DiOrEAK WHERE isMobileAvailable__c = true ORDER BY Mobile_Order__c) FROM Web_Form__c WHERE ID = '%@'", vfGeneratorId];
    
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
    
    //[selectQuery appendFormat:@" FROM Visa__c WHERE ID = '%@' LIMIT 1", self.visaId];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
    
}

- (void)getCardRecordType {
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        
        NSArray *recordTypesArray = [dict objectForKey:@"records"];
        cardManagementRecordTypesDictionary = [NSMutableDictionary new];
        
        for (NSDictionary *obj in recordTypesArray) {
            NSString *objectType = [obj objectForKey:@"SobjectType"];
            NSString *developerName = [obj objectForKey:@"DeveloperName"];
            
            if([objectType isEqualToString:@"Case"] && [developerName isEqualToString:@"Access_Card_Request"])
                caseRecordTypeId = [obj objectForKey:@"Id"];
            
            if([objectType isEqualToString:@"Card_Management__c"])
                [cardManagementRecordTypesDictionary setObject:[obj objectForKey:@"Id"] forKey:[obj objectForKey:@"DeveloperName"]];
        }
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        
    };
    
    NSString *selectQuery = @"SELECT Id, Name, DeveloperName, SobjectType FROM RecordType WHERE (SobjectType = 'Case' AND DeveloperName = 'Access_Card_Request') OR (SObjectType = 'Card_Management__c')";
    
    [[SFRestAPI sharedInstance] performSOQLQuery:selectQuery
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

- (void)createCaseRecord {
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            selectedServiceID ,@"Service_Requested__c",
                            self.accountId, @"AccountId",
                            caseRecordTypeId, @"RecordTypeId",
                            @"Draft", @"Status",
                            @"Access Card Services", @"Type",
                            @"Mobile", @"Origin",
                            nil];
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        insertedCaseId = [dict objectForKey:@"id"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createCardManagementRecord:insertedCaseId];
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

- (void)createCardManagementRecord:(NSString*)caseId {
    NSString *recordTypeId = [cardManagementRecordTypesDictionary objectForKey:selectedCardManagementRecordType];
    
    NSMutableDictionary *fields = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   self.accountId, @"Account__c",
                                   self.selectedDuration, @"Duration__c",
                                   recordTypeId, @"RecordTypeId",
                                   caseId, @"Request__c",
                                   currentWebForm.Id, @"Web_Form__c",
                                   nil];
    
    for (FormField *formField in currentWebForm.formFields) {
        if(!formField.isCalculated)
            [fields setValue:[formField getFormFieldValue] forKey:formField.name];
    }
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        insertedCardId = [dict objectForKey:@"id"];
        [HelperClass createCompanyDocuments:insertedCardId ParentField:@"Card_Management__c" Document:documentsArray CompanyID:self.accountId];
        [self updateCaseObject:insertedCaseId Card:insertedCardId];
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    [[SFRestAPI sharedInstance] performCreateWithObjectType:@"Card_Management__c"
                                                     fields:fields
                                                  failBlock:errorBlock
                                              completeBlock:successBlock];
}

- (void)updateCaseObject:(NSString*)caseId Card:(NSString*)cardId{
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            cardId, @"Card_Management__c",
                            nil];
    
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NewCardReviewViewController *newCardReviewVC = [NewCardReviewViewController new];
            newCardReviewVC.caseId = caseId;
            newCardReviewVC.currentWebForm = currentWebForm;
            
            [self.navigationController pushViewController:newCardReviewVC animated:YES];
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

#pragma UIPopoverControllerDelegate
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}

#pragma SFPickListViewDelegate
- (void)valuePickCanceled:(SFPickListViewController *)picklist {
    
}

- (void)valuePicked:(NSString *)value pickList:(SFPickListViewController *)picklist {
    if ([self.selectCardTypePopover isPopoverVisible]) {
        [self resetValues];
        
        for (NSInteger index = 0; index < cardTypesDescriptionsArray.count; index++) {
            if ([[cardTypesDescriptionsArray objectAtIndex:index] isEqualToString:value]) {
                self.selectedCardType = [cardTypesValuesArray objectAtIndex:index];
            }
        }
        [self.selectCardTypeButton setTitle:value forState:UIControlStateNormal];
        [self.selectCardTypePopover dismissPopoverAnimated:YES];
        
        [HelperClass removeFormFields:self.dynamicView];
    }
    if ([self.selectDurationPopover isPopoverVisible]) {
        self.selectedDuration = value;
        [self.selectDurationButton setTitle:value forState:UIControlStateNormal];
        [self.selectDurationPopover dismissPopoverAnimated:YES];
        
        [HelperClass removeFormFields:self.dynamicView];
        [self getServiceAdministrator];
    }
    
}


@end
