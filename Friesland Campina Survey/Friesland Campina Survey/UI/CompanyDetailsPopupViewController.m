//
//  SubmitPopupViewController.m
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/19/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import "CompanyDetailsPopupViewController.h"
#import "AppDelegate.h"
#import "HelperClass.h"
#import <QuartzCore/QuartzCore.h>

@interface CompanyDetailsPopupViewController ()

@end

@implementation CompanyDetailsPopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.currentCompanyType = RegisteredCompany;
	
	self.nameLabelField.text = NSLocalizedString(@"company_name_label", nil);
	//self.nameLabelField.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:17];
	self.nameLabelField.font = [UIFont fontWithName:@"RopaSans-Regular" size:17];
	
	self.personNameLabelField.text = NSLocalizedString(@"person_name_label", nil);
	//self.personNameLabelField.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:17];
	self.personNameLabelField.font = [UIFont fontWithName:@"RopaSans-Regular" size:17];
	
	self.designationLabelField.text = NSLocalizedString(@"designation_label", nil);
	//self.designationLabelField.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:17];
	self.designationLabelField.font = [UIFont fontWithName:@"RopaSans-Regular" size:17];
	
	[self.selectButton setTitle:NSLocalizedString(@"select", nil) forState:UIControlStateNormal];
	[self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//self.selectButton.titleLabel.font = [UIFont fontWithName:@"BigNoodleTitling" size:44];
	self.selectButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:44];
	
	self.nameTextField.placeholder = NSLocalizedString(@"company_name_placeholder", nil);
	self.nameTextField.layer.cornerRadius = 8.0f;
    self.nameTextField.layer.masksToBounds = YES;
    self.nameTextField.layer.borderColor = [[UIColor colorWithRed:0.035f green:0.46f blue:0.683f alpha:1.0f] CGColor];
    self.nameTextField.layer.borderWidth = 1.0f;
	
	self.personNameTextField.placeholder = NSLocalizedString(@"person_name_placeholder", nil);
	self.personNameTextField.layer.cornerRadius = 8.0f;
    self.personNameTextField.layer.masksToBounds = YES;
    self.personNameTextField.layer.borderColor = [[UIColor colorWithRed:0.035f green:0.46f blue:0.683f alpha:1.0f] CGColor];
    self.personNameTextField.layer.borderWidth = 1.0f;
	
	self.designationTextField.placeholder = NSLocalizedString(@"designation_placeholder", nil);
	self.designationTextField.layer.cornerRadius = 8.0f;
    self.designationTextField.layer.masksToBounds = YES;
	self.designationTextField.layer.borderColor = [[UIColor colorWithRed:0.035f green:0.46f blue:0.683f alpha:1.0f] CGColor];
    self.designationTextField.layer.borderWidth = 1.0f;
	
	[self.registeredButton setTitle:NSLocalizedString(@"registered_company_title", nil) forState:UIControlStateNormal];
	[self.registeredButton setBackgroundImage:[UIImage imageNamed:@"TransparentButtonBackground.png"] forState:UIControlStateNormal];
	[self.registeredButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.registeredButton setBackgroundImage:[UIImage imageNamed:@"WhiteButtonBackground.png"] forState:UIControlStateSelected];
	[self.registeredButton setTitleColor:[UIColor colorWithRed:0.035f green:0.46f blue:0.683f alpha:1.0f] forState:UIControlStateSelected];
	//self.registeredButton.titleLabel.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:20];
	self.registeredButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:20];
	[self.registeredButton setSelected:YES];
	
	[self.nonRegisteredButton setTitle:NSLocalizedString(@"non_registered_company_title", nil) forState:UIControlStateNormal];
	[self.nonRegisteredButton setBackgroundImage:[UIImage imageNamed:@"TransparentButtonBackground.png"] forState:UIControlStateNormal];
	[self.nonRegisteredButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.nonRegisteredButton setBackgroundImage:[UIImage imageNamed:@"WhiteButtonBackground.png"] forState:UIControlStateSelected];
	[self.nonRegisteredButton setTitleColor:[UIColor colorWithRed:0.035f green:0.46f blue:0.683f alpha:1.0f] forState:UIControlStateSelected];
	//self.nonRegisteredButton.titleLabel.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:20];
	self.nonRegisteredButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:20];
	
	[self resetFields];
	
	self.suggestionTableView.dataSource = self;
	self.suggestionTableView.delegate = self;
	
	UIView* bview = [[UIView alloc] init];
	bview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
	[self.suggestionTableView setBackgroundView:bview];
	self.suggestionTableView.layer.cornerRadius = 2.0;
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(dismissKeyboard)];
	tap.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:tap];
	
	[HelperClass copyFileToDocuments:@"AccountsList.plist"];
	[HelperClass copyFileToDocuments:@"Utilities.plist"];
	
	NSString* homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	
	self.accountsPlistPath = [homeDir stringByAppendingPathComponent:@"AccountsList.plist"];
	self.utilitiesPlistPath = [homeDir stringByAppendingPathComponent:@"Utilities.plist"];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self getAccountsList];
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeAndStartActivityIndicatorSpinner
{
	[_spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	_spinner.color = [UIColor blackColor];
	
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[_spinner startAnimating];
}

- (void)stopActivityIndicatorSpinner
{
	[_spinner stopAnimating];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (IBAction)designationEmailTextChanged:(id)sender {
	self.designation = self.designationTextField.text;
}

- (IBAction)personNameTextChanged:(id)sender {
	self.personName = self.personNameTextField.text;
}

- (IBAction)companyNameTextChanged:(id)sender {
	self.companyName = self.nameTextField.text;
	self.companyId = @"";
	self.personNameTextField.text = @"";
	[self.personNameTextField sendActionsForControlEvents:UIControlEventEditingChanged];
	self.designationTextField.text = @"";
	[self.designationTextField sendActionsForControlEvents:UIControlEventEditingChanged];
	
	if (self.currentCompanyType == NonRegisteredCompany)
		return;
	
	if (self.nameTextField.text.length == 0)
	{
		[self.suggestionTableView setHidden:YES];
	}
	else
	{
		[self.suggestionTableView setHidden:NO];
		[self refreshSuggestionsTable];
	}
}

- (IBAction)doneClicked:(id)sender {
	if([self validateSubmit])
		[self.companyDetailsDelegate donePopoverWithCompanyId:self.companyId CompanyName:self.companyName PersonName:self.personName Designation:self.designation];
}

- (IBAction)sectionButtonClicked:(id)sender {
	UIButton *selectedButton = (UIButton*)sender;
	
	self.currentCompanyType = (CompanyType)selectedButton.tag;
	
	if (self.currentCompanyType == RegisteredCompany)
	{
		[self.registeredButton setSelected:YES];
		[self.nonRegisteredButton setSelected:NO];
	}
	else
	{
		[self.registeredButton setSelected:NO];
		[self.nonRegisteredButton setSelected:YES];
	}
	
	[self dismissKeyboard];
	[self resetFields];
}

- (void)dismissKeyboard {
	[self.view endEditing:YES];
}

- (void)setLabelFieldValidationColor:(UILabel*)label IsValid:(BOOL)valid {
	if (valid)
		[label setTextColor:[UIColor blackColor]];
	else
		[label setTextColor:[UIColor redColor]];
}

- (BOOL)validateSubmit {
	BOOL returnValue = YES;
	
	if (self.currentCompanyType == NonRegisteredCompany)
		self.companyId = @"-1";
	
	if (self.currentCompanyType == RegisteredCompany && [self.companyId isEqualToString:@""])
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"select_registered_company_title", nil) message:NSLocalizedString(@"select_registered_company_message", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
		
		[self setLabelFieldValidationColor:self.nameLabelField IsValid:NO];
		
		[alertView show];
		
		return NO;
	}
	
	if ([self.companyName isEqual:@""])
	{
		returnValue &= NO;
		[self setLabelFieldValidationColor:self.nameLabelField IsValid:NO];
	}
	else
	{
		[self setLabelFieldValidationColor:self.nameLabelField IsValid:YES];
	}
	
	if ([self.personName isEqual:@""])
	{
		returnValue &= NO;
		[self setLabelFieldValidationColor:self.personNameLabelField IsValid:NO];
	}
	else
	{
		[self setLabelFieldValidationColor:self.personNameLabelField IsValid:YES];
	}
	
	if ([self.designation isEqual:@""])
	{
		returnValue &= NO;
		[self setLabelFieldValidationColor:self.designationLabelField IsValid:NO];
	}
	else
	{
		[self setLabelFieldValidationColor:self.designationLabelField IsValid:YES];
	}
	
	return returnValue;
}

- (void)refreshSuggestionsTable {
	[self.filteredAccountArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Name contains[c] %@", self.companyName];
    self.filteredAccountArray = [NSMutableArray arrayWithArray:[self.jsonArray filteredArrayUsingPredicate:predicate]];
	
	NSInteger tableHeight = 44 * self.filteredAccountArray.count;
	
	tableHeight = tableHeight > 141 ? 141 : tableHeight;
	
	self.suggestionTableView.frame = CGRectMake(self.suggestionTableView.frame.origin.x, self.suggestionTableView.frame.origin.y, self.suggestionTableView.frame.size.width, tableHeight);
	
	[self.suggestionTableView reloadData];
}

- (void)resetFields {
	
	self.personNameTextField.text = @"";
	self.nameTextField.text = @"";
	self.designationTextField.text = @"";
	
	self.companyId = @"";
	self.companyName = @"";
	self.personName = @"";
	self.designation = @"";
	
	[self setLabelFieldValidationColor:self.nameLabelField IsValid:YES];
	[self setLabelFieldValidationColor:self.personNameLabelField IsValid:YES];
	[self setLabelFieldValidationColor:self.designationLabelField IsValid:YES];
	[self.suggestionTableView setHidden:YES];
}

- (void)getAccountsList {
	NSString *accountsPlistPath = [[NSBundle mainBundle] pathForResource: @"AccountsList" ofType: @"plist"];
	NSMutableData *accountsData = [NSMutableData dataWithContentsOfFile:accountsPlistPath];
	
	NSString *utilitiesPlistPath = [[NSBundle mainBundle] pathForResource: @"Utilities" ofType: @"plist"];
	NSDictionary *utilitiesDictionary = [NSDictionary dictionaryWithContentsOfFile: utilitiesPlistPath];
	
	NSDate *lastSyncDate = [utilitiesDictionary objectForKey:@"Last_Sync_Date"];
	NSInteger syncAfterTimeInterval = [lastSyncDate timeIntervalSinceNow] / 3600;
	syncAfterTimeInterval *= -1; //This is because the lastSyncDate will always be in the past.
	
	if(accountsData.length < 50 || syncAfterTimeInterval > 23 )
	{
		[self updateAccountsList];
	}
	else
	{
		[self performSelector:@selector(updateAccountsList) withObject:nil afterDelay:(24 - syncAfterTimeInterval) * 3600];
		
		self.responseData = accountsData;
		[self connectionDidFinishLoading:nil];
	}
	
}

- (void)updateAccountsList {
	[self initializeAndStartActivityIndicatorSpinner];
	self.responseData = [[NSMutableData alloc] init];
	
	NSURL *url = [NSURL URLWithString:kSurveyAccountsWebservice];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	//Create GET HTTP Method Request
	[request setHTTPMethod:@"GET"];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	NSError *error = nil;
	self.jsonArray = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
	
	[self stopActivityIndicatorSpinner];
	
	if (error != nil) {
		NSLog(@"Error parsing JSON.");
	}
	else {
		NSLog(@"Array: %@", self.jsonArray);
	}
	
	if(connection != nil)
	{
		NSString *utilitiesPlistPath = [[NSBundle mainBundle] pathForResource: @"Utilities" ofType: @"plist"];
		NSMutableDictionary *utilitiesDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: utilitiesPlistPath];
		
		[utilitiesDictionary setValue:[NSDate date] forKey:@"Last_Sync_Date"];
		[utilitiesDictionary writeToFile:utilitiesPlistPath atomically:YES];
		
		[self.responseData writeToFile:[[NSBundle mainBundle] pathForResource: @"AccountsList" ofType: @"plist"] atomically:YES];
	}
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"error - read error object for details");
	
	[self stopActivityIndicatorSpinner];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't update list of companies. Error contacting server, please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
	[alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.filteredAccountArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellIdentifier";
	
	// Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
		
    }
	//if you want to add an image to your cell, here's how
	//UIImage *image = [UIImage imageNamed:@"icon.png"];
	//cell.imageView.image = image;
	
	// Configure the cell to show the data.
	NSDictionary *obj;
	obj = [self.filteredAccountArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text =  [obj objectForKey:@"Name"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *selectedAccountItem = [self.filteredAccountArray objectAtIndex:indexPath.row];
	
	self.companyId = [selectedAccountItem objectForKey:@"Id"];
	self.companyName = [selectedAccountItem objectForKey:@"Name"];
	
	self.nameTextField.text = self.companyName;
	self.personNameTextField.text = self.personName;
	self.designationTextField.text = self.designation;
	
	[self.suggestionTableView setHidden:YES];
}
@end
