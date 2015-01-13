//
//  ContactsDetailViewController.m
//  Sawahi
//
//  Created by Mina Zaklama on 1/22/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "ContactsDetailViewController.h"
#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "SFAccountManager.h"

@interface ContactsDetailViewController ()

@end

@implementation ContactsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.navigationItem.title = self.contactName;
	
	_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	CGPoint screenCenterPoint;
	if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
	{
		screenCenterPoint = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height / 2);
	}
	else if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
	{
		screenCenterPoint = CGPointMake([[UIScreen mainScreen] bounds].size.height / 2, [[UIScreen mainScreen] bounds].size.width / 2);
	}

	_spinner.center = screenCenterPoint;
	
	_spinner.color = [UIColor blackColor];
	[self.view addSubview:_spinner];
	[_spinner startAnimating];
	
	self.firstNameLabelField.text = NSLocalizedString(@"first_name_label", nil);
	self.lastNameLabelField.text = NSLocalizedString(@"last_name_label", nil);
	self.nationalityLabelField.text = NSLocalizedString(@"nationality_label", nil);
	self.countryOfBirthLabelField.text = NSLocalizedString(@"country_of_birth_label", nil);
	self.birthDateLabelField.text = NSLocalizedString(@"birth_date_label", nil);
	
	NSString *query = [NSString stringWithFormat:@"SELECT FirstName, LastName, Nationality__r.Name, Country_of_Birth__r.Name, Birthdate FROM Contact WHERE Id = '%@'", self.contactId];
	
	SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];
	
    [[SFRestAPI sharedInstance] send:request delegate:self];
	
	
	NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:[NSString stringWithFormat: @"https://mobileapp-afzamobileapp.cs8.force.com/mobileapp/apex/TestContact?id=%@", self.contactId]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:1];
	
	NSString *authHeader = [[NSString alloc] initWithFormat:@"OAuth %@", [SFAccountManager sharedInstance].credentials.accessToken];
    //[req setHTTPMethod:@"GET"];
    //[request2 setValue:authHeader forHTTPHeaderField:@"Authorization"];
	
	
	
	[self.webView loadRequest: request2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    self.dataRows = records;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshDisplayedData];
		[_spinner stopAnimating];
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

#pragma mark - private methods
- (void)refreshDisplayedData
{
	if ([self.dataRows count] > 0)
	{
		NSDictionary *currentContactDict = [self.dataRows objectAtIndex:0];
		self.firstNameValueField.text = [currentContactDict objectForKey:@"FirstName"];
		self.lastNameValueField.text = [currentContactDict objectForKey:@"LastName"];
		self.birthDateValueField.text = [currentContactDict objectForKey:@"Birthdate"];
		self.nationalityValueField.text = [[currentContactDict objectForKey:@"Nationality__r"] objectForKey:@"Name"];
		self.countryOfBirthValueField.text = [[currentContactDict objectForKey:@"Country_of_Birth__r"] objectForKey:@"Name"];
	}
}


@end
