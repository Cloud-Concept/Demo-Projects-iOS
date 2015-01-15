//
//  NonEmployeesTableViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "NonEmployeesTableViewController.h"
#import "NewCardViewController.h"
#import "CardManagement.h"
#import "RecordType.h"
#import "Country.h"

@interface NonEmployeesTableViewController ()

@end

@implementation NonEmployeesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Non Employees";
    
    //Here we use a query that should work on either Force.com or Database.com
    SFRestRequest *request = [[SFRestAPI sharedInstance]
                              requestForQuery:[NSString stringWithFormat: @"SELECT Id, Card_Expiry_Date__c, Card_Type__c, Status__c, Nationality__r.Id, Nationality__r.Name, Full_Name__c, Visa__r.Personal_Photo__c, Name, Card_Number__c, Company_Name__c, Duration__c, Recordtype.DeveloperName, Recordtype.Name, Recordtype.Id, Recordtype.IsActive, Recordtype.SobjectType FROM Card_Management__C WHERE Account__c = '%@' ORDER BY Full_Name__c", self.accountId]];
    
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
    
    for (NSDictionary* dict in records) {
        
        NSDictionary *recordTypeDict = [dict objectForKey:@"RecordType"];
        RecordType *recordType = [RecordType new];
        if (![recordTypeDict isKindOfClass:[NSNull class]])
            recordType = [[RecordType alloc] initRecordType:[recordTypeDict objectForKey:@"Id"]
                                                       Name:[recordTypeDict objectForKey:@"name"]
                                              DeveloperName:[recordTypeDict objectForKey:@"DeveloperName"]
                                                   IsActive:[[recordTypeDict objectForKey:@"IsActive"] boolValue]
                                                 ObjectType:[recordTypeDict objectForKey:@"SobjectType"]];
        
        NSDictionary *nationalityDict = [dict objectForKey:@"Nationality__r"];
        Country *nationality = [Country new];
        if (![nationalityDict isKindOfClass:[NSNull class]])
            nationality = [[Country alloc] initCountry:[nationalityDict objectForKey:@"Id"]
                                                  Name:[nationalityDict objectForKey:@"Name"]
                                     AramexCountryCode:@""
                                     CountryNameArabic:@""
                                              DNRDName:@""
                                              FromCode:@""
                                              IsActive:YES
                                       NationalityName:@""
                                 NationalityNameArabic:@""];
        
        [self.dataRows addObject:[[CardManagement alloc] initCardManagement:[dict objectForKey:@"Id"]
                                                             CardExpiryDate:[dict objectForKey:@"Card_Expiry_Date__c"]
                                                                 CardNumber:[dict objectForKey:@"Card_Number__c"]
                                                                   CardType:[dict objectForKey:@"Card_Type__c"]
                                                                CompanyName:[dict objectForKey:@"Company_Name__c"]
                                                                   Duration:[dict objectForKey:@"Duration__c"]
                                                                   FullName:[dict objectForKey:@"Full_Name__c"]
                                                                       Name:[dict objectForKey:@"Name"]
                                                                Nationality:nationality
                                                                 Recordtype:recordType
                                                                     Status:[dict objectForKey:@"Status__c"]]];
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
    CardManagement *obj = [self.dataRows objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.fullName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCard = [self.dataRows objectAtIndex:indexPath.row];
    
    NSArray* stringArray = @[@"Renew Card", @"Replace/Lost Card", @"Cancel Card"];
    
    SFPickListViewController *pickListViewController = [SFPickListViewController createPickListViewController:stringArray selectedValue:@""];
    
    pickListViewController.delegate = self;
    pickListViewController.preferredContentSize = CGSizeMake(320, stringArray.count * 44);
    
    self.chooseCardPopover = [[UIPopoverController alloc] initWithContentViewController:pickListViewController];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect=CGRectMake(cell.bounds.origin.x+600, cell.bounds.origin.y+10, 50, 30);
    [self.chooseCardPopover presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma SFPickListViewDelegate
- (void)valuePickCanceled:(SFPickListViewController *)picklist {
    
}

- (void)valuePicked:(NSString *)value pickList:(SFPickListViewController *)picklist {
    [self.chooseCardPopover dismissPopoverAnimated:YES];
    //selectedCard
    NewCardViewController *newCardVC = [NewCardViewController new];
    
    if ([value isEqualToString:@"Renew Card"]) {
        newCardVC.operationType = @"RenewCard";
    }
    else if([value isEqualToString:@"Replace/Lost Card"]) {
        newCardVC.operationType = @"ReplaceCard";
    }
    else if ([value isEqualToString:@"Cancel Card"]) {
        newCardVC.operationType = @"CancelCard";
    }
    
    newCardVC.selectedCardType = selectedCard.recordType.developerName;
    newCardVC.selectedDuration = selectedCard.duration;
    newCardVC.accountId = self.accountId;
    
    [self.navigationController pushViewController:newCardVC animated:YES];
}


@end
