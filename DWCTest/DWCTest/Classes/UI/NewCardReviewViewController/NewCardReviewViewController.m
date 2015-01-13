//
//  NewCardReviewViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 1/5/15.
//  Copyright (c) 2015 CloudConcept. All rights reserved.
//

#import "NewCardReviewViewController.h"
#import "SFRestAPI+Blocks.h"
#import "WebForm.h"
#import "FormField.h"
#import "HelperClass.h"

@interface NewCardReviewViewController ()

@end

@implementation NewCardReviewViewController

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
                
                NSDictionary *nocDict = [dict objectForKey:@"Card_Management__r"];
                [self.cardTypeTextField setText:[nocDict objectForKey:@"Card_Type__c"]];
                [self.durationTextField setText:[nocDict objectForKey:@"Duration__c"]];
                
                for (FormField *field in self.currentWebForm.formFields) {
                    [field setFormFieldValue:[nocDict objectForKey:field.name]];
                    field.isCalculated = true;
                }
                
                [HelperClass drawFormFields:self.currentWebForm DynamicView:self.dynamicView];
                
            }
        });
    };
    
    void (^errorBlock) (NSError*) = ^(NSError *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DWC" message:@"An error occured" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alert show];
        });
        
    };
    
    NSMutableString *queryString = [[NSMutableString alloc] initWithString:@"SELECT CaseNumber, CreatedDate, Status, Type, Card_Management__r.Duration__c, Card_Management__r.Card_Type__c, (SELECT ID, Amount__c FROM Invoices__r)"];
    
    for (FormField *field in self.currentWebForm.formFields) {
        NSString *fieldName = [NSString stringWithFormat:@", Card_Management__r.%@", field.name];
        
        if (![queryString containsString:fieldName]) {
            [queryString appendString:fieldName];
        }
        
    }
    
    [queryString appendFormat:@" FROM Case WHERE Id = '%@'", self.caseId];
    
    [[SFRestAPI sharedInstance] performSOQLQuery:queryString
                                       failBlock:errorBlock
                                   completeBlock:successBlock];
}

- (void)callPayAndSubmitWebservice {
    
    // Manually set up request object
    [HelperClass callPayAndSubmitWebservice:self.caseId Delegate:self];
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
