//
//  NOCReviewViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/31/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "NOCReviewViewController.h"
#import "SFRestAPI+Blocks.h"
#import "WebForm.h"
#import "FormField.h"
#import "HelperClass.h"

@interface NOCReviewViewController ()

@end

@implementation NOCReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getCaseDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payAndSubmitButtonClicked:(id)sender {
    [self callPayAndSubmitWebservice];
}

- (void)callPayAndSubmitWebservice {
    
    // Manually set up request object
    [HelperClass callPayAndSubmitWebservice:self.caseId Delegate:self];
}

- (void)getCaseDetails {
    void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *records = [dict objectForKey:@"records"];
            NSLog(@"request:didLoadResponse: #records: %d", records.count);
            
            for (NSDictionary *dict in records) {
                [self.requestNumberTextField setText:[dict objectForKey:@"CaseNumber"]];
                [self.requestStatusTextField setText:[dict objectForKey:@"Status"]];
                [self.requestTypeTextField setText:[dict objectForKey:@"Type"]];
                [self.requestCreatedDateTextField setText:[dict objectForKey:@"CreatedDate"]];
                
                NSArray *invoicesArray = [dict objectForKey:@"Invoices__r"];
                if(![invoicesArray isKindOfClass:[NSNull class]]) {
                    NSNumber *totalAmount = 0;
                    for (NSDictionary *invoiceDict in invoicesArray) {
                        NSNumber *currentAmount = [invoiceDict objectForKey:@"Amount__c"];
                        totalAmount = [NSNumber numberWithFloat:([totalAmount floatValue] + [currentAmount floatValue])];
                    }
                    
                    [self.totalChargesTextField setText:[totalAmount stringValue]];
                }
                
                NSDictionary *nocDict = [dict objectForKey:@"NOC__r"];
                [self.nocTypeTextField setText:[nocDict objectForKey:@"Document_Name__c"]];
                [self.languageTextField setText:[nocDict objectForKey:@"NOC_Language__c"]];
                [self.requiredCourierSwitch setOn:[[nocDict objectForKey:@"isCourierRequired__c"] boolValue]];
                
                for (FormField *field in self.currentWebForm.formFields) {
                    [field setFormFieldValue:[nocDict objectForKey:field.name]];
                    field.isCalculated = true;
                    if ([field.name containsString:@"NOC_Language__c"])
                        field.hidden = YES;
                }
                
                [HelperClass drawFormFields:self.currentWebForm DynamicView:self.dynamicVIew];
                
            }
        });
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    NSMutableString *queryString = [[NSMutableString alloc] initWithString:@"SELECT CaseNumber, CreatedDate, Status, Type, NOC__r.Document_Name__c, NOC__r.NOC_Language__c, NOC__r.isCourierRequired__c, (SELECT ID, Amount__c FROM Invoices__r)"];
    
    for (FormField *field in self.currentWebForm.formFields) {
        NSString *fieldName = [NSString stringWithFormat:@", NOC__r.%@", field.name];
        
        if (![queryString containsString:fieldName]) {
            [queryString appendString:fieldName];
        }
        
    }
    
    [queryString appendFormat:@" FROM Case WHERE Id = '%@'", self.caseId];
   
    [[SFRestAPI sharedInstance] performSOQLQuery:queryString
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    NSLog(@"request:didLoadResponse: %@", dict);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
