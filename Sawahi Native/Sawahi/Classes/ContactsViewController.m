/*
 Copyright (c) 2011, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "ContactsViewController.h"
#import "SWRevealViewController.h"
#import "ContactsDetailViewController.h"

#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "SFAccountManager.h"
#import "SFAuthenticationManager.h"
//#import "SFHybridViewConfig.h"
//#import "SFHybridViewController.h"

@implementation ContactsViewController

@synthesize dataRows;

#pragma mark Misc

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.dataRows = nil;
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"contacts", nil);
	
	// Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
	
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
	
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
	//Here we use a query that should work on either Force.com or Database.com
    //SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Id, Name FROM Contact WHERE AccountId='001L000000KcDOUIA3'"];
	
	NSString *query = [NSString stringWithFormat:@"SELECT Id, Name FROM Contact WHERE AccountId IN (Select AccountId FROM User WHERE Id = '%@')", [SFAccountManager sharedInstance].credentials.userId];
	
	SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];
	
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    self.dataRows = records;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataRows count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *CellIdentifier = @"CellIdentifier";

   // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

    }
	//if you want to add an image to your cell, here's how
	//UIImage *image = [UIImage imageNamed:@"icon.png"];
	//cell.imageView.image = image;

	// Configure the cell to show the data.
	NSDictionary *obj = [dataRows objectAtIndex:indexPath.row];
	cell.textLabel.text =  [obj objectForKey:@"Name"];

	//this adds the arrow to the right hand side.
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	NSDictionary *selectedContact = [self.dataRows objectAtIndex:indexPath.row];
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	ContactsDetailViewController *contactDetailView = [storyBoard instantiateViewControllerWithIdentifier:@"ContactDetailViewController"];
	
	contactDetailView.contactId = [selectedContact objectForKey:@"Id"];
	contactDetailView.contactName = [selectedContact objectForKey:@"Name"];
	
	[self.navigationController pushViewController:contactDetailView animated:YES];
	 */
	
	/*SFHybridViewConfig *contactsHybridConfig = [SFHybridViewConfig fromConfigFile:@"www/contactsConfig.json"];
	contactsHybridConfig.startPage = [NSString stringWithFormat:@"%@?id=%@", contactsHybridConfig.startPage, [selectedContact objectForKey:@"Id" ]];
	SFHybridViewController *contactsHybridView = [[SFHybridViewController alloc] initWithConfig:contactsHybridConfig];
	[self.navigationController pushViewController:contactsHybridView animated:YES];*/

	NSDictionary *selectedContact = [self.dataRows objectAtIndex:indexPath.row];
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	UIViewController *contactDetailView = [storyBoard instantiateViewControllerWithIdentifier:@"WebView"];
	
	UIWebView *webview = (UIWebView*)[contactDetailView.view viewWithTag:10];
	NSURL *url = [SFAuthenticationManager frontDoorUrlWithReturnUrl:@"apex/MobileAppContactsList" returnUrlIsEncoded:NO];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url  cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	
	SFOAuthCredentials *creds = [SFAccountManager sharedInstance].credentials;
	NSString *frontDoorUrl = [NSString stringWithFormat:@"https://mobileapp-afzamobileapp.cs8.force.com/mobileapp/apex/MobileAppContactsList?oauth_token=%@", creds.accessToken];
	
	NSString *encodedUrlString = [frontDoorUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	//[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedUrlString]]];
	
	[webview loadRequest:request];
	
	[self.navigationController pushViewController:contactDetailView animated:YES];
	
}

@end
