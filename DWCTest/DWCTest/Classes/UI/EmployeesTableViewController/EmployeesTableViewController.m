//
//  EmployeesTableViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 11/25/14.
//  Copyright (c) 2014 Zapp. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import "NewNOCViewController.h"
#import "Visa.h"
#import "Account.h"

@interface EmployeesTableViewController ()

@end

@implementation EmployeesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Employees";
    
    //Here we use a query that should work on either Force.com or Database.com
    SFRestRequest *request = [[SFRestAPI sharedInstance]
                              requestForQuery:[NSString stringWithFormat: @"SELECT Id, Name, Passport_Number__c, Passport_Country__c, Sponsoring_Company__c, Sponsoring_Company__r.Name, Visa_Holder__c, Visa_Holder__r.Name, Visa_Holder__r.BillingCity, Visa_Holder__r.BillingCountryCode FROM Visa__c WHERE Sponsoring_Company__c = '%@' AND Visa_Holder__c != null AND Visa_Validity_Status__c IN ('Active', 'Issued') ORDER BY Visa_Holder__r.Name", self.accountId]];
    
    [[SFRestAPI sharedInstance] send:request delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    self.dataRows = [NSMutableArray new];
    
    for (NSDictionary *dict in records) {
        NSDictionary *visaHolderDictionary = [dict objectForKey:@"Visa_Holder__r"];
        Account *visaHolder = [[Account alloc] initAccount:[dict objectForKey:@"Visa_Holder__c"]
                                                      Name:[visaHolderDictionary objectForKey:@"Name"]
                                               BillingCity:[visaHolderDictionary objectForKey:@"BillingCity"]
                                        BillingCountryCode:[visaHolderDictionary objectForKey:@"BillingCountryCode"]];
        
        NSDictionary *sponsoringCompanyDict = [dict objectForKey:@"Sponsoring_Company__r"];
        Account *sponsoringCompany = [[Account alloc] initAccount:[dict objectForKey:@"Sponsoring_Company__c"]
                                                             Name:[sponsoringCompanyDict objectForKey:@"Name"]
                                                      BillingCity:@""
                                               BillingCountryCode:@""];
        
        [self.dataRows addObject:[[Visa alloc] initVisa:[dict objectForKey:@"Id"]
                                                   Name:[dict objectForKey:@"Name"]
                                        PassportCountry:[dict objectForKey:@"Passport_Country__c"]
                                         PassportNumber:[dict objectForKey:@"Passport_Number__c"]
                                      SponsoringCompany:sponsoringCompany
                                             VisaHolder:visaHolder]];
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    //if you want to add an image to your cell, here's how
    UIImage *image = [UIImage imageNamed:@"icon.png"];
    cell.imageView.image = image;
    
    // Configure the cell to show the data.
    Visa *obj = [self.dataRows objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.visaHolder.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewNOCViewController *nocVC = [[NewNOCViewController alloc] init];
    
    Visa *obj = [self.dataRows objectAtIndex:indexPath.row];
    nocVC.accountId = self.accountId;
    nocVC.accountBalance = self.accountBalance;
    nocVC.employeeId = obj.visaHolder.Id;
    nocVC.visaId = obj.Id;
    nocVC.employeeName = obj.visaHolder.name;
    nocVC.passportNumber = obj.passportNumber;
    nocVC.passportCountry = obj.passportCountry;
    nocVC.visaNumber = obj.name;
    nocVC.billingCountry = obj.visaHolder.billingCountryCode;
    nocVC.billingCity = obj.visaHolder.billingCity;
    
    [self.navigationController pushViewController:nocVC animated:YES];
}

@end
