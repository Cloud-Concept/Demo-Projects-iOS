//
//  HeaderUIViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "HeaderUIViewController.h"
#import "NotificationsPopoverViewController.h"
#import "HelperClass.h"

@interface HeaderUIViewController ()

@end

@implementation HeaderUIViewController

- (id)initWithActiveTab:(ApplicationTab)tab customerName:(NSString*)name {
	self = [super initWithNibName:@"HeaderUIViewController" bundle:nil];
	if (self) {
		// Custom initialization
		self.activeTab = tab;
		self.customerName = name;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self activateTab:self.activeTab];
	[self setCustomerNameText:self.customerName];
	
	UIImage *profileImage = [HelperClass maskImage:[UIImage imageNamed:@"Default Profile Image"] withMask:[UIImage imageNamed:@"Circle Mask"]];
	
	self.profileImageView.image = profileImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButtonClicked:(id)sender {
	if([self toggleTabActivation:Home])
		[self.delegate headerViewHomeButtonClicked];
}

- (IBAction)employeesButtonClicked:(id)sender {
	if([self toggleTabActivation:Employees])
		[self.delegate headerViewEmployeesButtonClicked];
}

- (IBAction)companyButtonClicked:(id)sender {
	if([self toggleTabActivation:Company])
		[self.delegate headerViewCompanyButtonClicked];
}

- (IBAction)leasesButtonClicked:(id)sender {
	if([self toggleTabActivation:Leases])
		[self.delegate headerViewLeasesButtonClicked];
}

- (IBAction)serviceHistoryButtonClicked:(id)sender {
	if([self toggleTabActivation:ServiceHistory])
		[self.delegate headerViewServiceHistoryButtonClicked];
}

- (IBAction)paymentsButtonClicked:(id)sender {
	if([self toggleTabActivation:Payments])
		[self.delegate headerViewPaymentsButtonClicked];
}

- (IBAction)settingsButtonClicked:(id)sender {
	if ([self.delegate respondsToSelector:@selector(headerViewSettingsButtonClicked)])
		[self.delegate headerViewSettingsButtonClicked];
	
	[self openSettingsPopover];
}

- (IBAction)notificationsButtonClicked:(id)sender {
	if ([self.delegate respondsToSelector:@selector(headerViewNotificationsButtonClicked)])
		[self.delegate headerViewNotificationsButtonClicked];
	
	[self openNotificationsPopover];
}

- (void)openSettingsPopover {
	if (!self.settingsPopover) {
		SettingsPopoverViewController *settingsController = [[SettingsPopoverViewController alloc] initSettingsPopoverViewController];
	
		settingsController.delegate = self;
	
		self.settingsPopover = [[UIPopoverController alloc] initWithContentViewController:settingsController];
		self.settingsPopover.popoverContentSize = settingsController.view.frame.size;
	}
	
	[self.settingsPopover presentPopoverFromRect:self.settingsButton.frame inView:self.settingsButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)openNotificationsPopover {
	if(!self.notificationsPopover) {
		NotificationsPopoverViewController *notificationsController = [[NotificationsPopoverViewController alloc] initSettingsPopoverViewController];
	
		self.notificationsPopover = [[UIPopoverController alloc] initWithContentViewController:notificationsController];
		self.notificationsPopover.popoverContentSize = notificationsController.view.frame.size;
	}
	
	[self.notificationsPopover presentPopoverFromRect:self.notificationsButton.frame inView:self.notificationsButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (BOOL)toggleTabActivation:(ApplicationTab)newTab {
	
	if (newTab == self.activeTab)
		return NO;
	
	[self deactivateTab:self.activeTab];
	[self activateTab:newTab];
	return YES;
}

- (void)setCustomerNameText:(NSString *)customerName {
	self.customerName = customerName;
	self.nameLabel.text = self.customerName;
}

- (void)deactivateTab:(ApplicationTab)tab {
	switch (tab) {
		case Home:
			[self.homeButton setBackgroundImage:[UIImage imageNamed:@"Home Icon Inactive"] forState:UIControlStateNormal];
			break;
		case Employees:
			[self.employeesButton setBackgroundImage:[UIImage imageNamed:@"Employees Icon Inactive"] forState:UIControlStateNormal];
			break;
		case Company:
			[self.companyButton setBackgroundImage:[UIImage imageNamed:@"Company Icon Inactive"] forState:UIControlStateNormal];
			break;
		case Leases:
			[self.leasesButton setBackgroundImage:[UIImage imageNamed:@"Leases Icon Inactive"] forState:UIControlStateNormal];
			break;
		case ServiceHistory:
			[self.serviceHistoryButton setBackgroundImage:[UIImage imageNamed:@"Service History Icon Inactive"] forState:UIControlStateNormal];
			break;
		case Payments:
			[self.paymentsButton setBackgroundImage:[UIImage imageNamed:@"Payments Icon Inactive"] forState:UIControlStateNormal];
			break;
		default:
			break;
	}
}

- (void)activateTab:(ApplicationTab)tab {
	switch (tab) {
		case Home:
			[self.homeButton setBackgroundImage:[UIImage imageNamed:@"Home Icon Active"] forState:UIControlStateNormal];
			break;
		case Employees:
			[self.employeesButton setBackgroundImage:[UIImage imageNamed:@"Employees Icon Active"] forState:UIControlStateNormal];
			break;
		case Company:
			[self.companyButton setBackgroundImage:[UIImage imageNamed:@"Company Icon Active"] forState:UIControlStateNormal];
			break;
		case Leases:
			[self.leasesButton setBackgroundImage:[UIImage imageNamed:@"Leases Icon Active"] forState:UIControlStateNormal];
			break;
		case ServiceHistory:
			[self.serviceHistoryButton setBackgroundImage:[UIImage imageNamed:@"Service History Icon Active"] forState:UIControlStateNormal];
			break;
		case Payments:
			[self.paymentsButton setBackgroundImage:[UIImage imageNamed:@"Payments Icon Active"] forState:UIControlStateNormal];
			break;
		default:
			break;
	}
	
	self.activeTab = tab;
}

#pragma SettingsPopoverDelegate Methods
- (void)manageUsersButtonClicked {
	
}

- (void)smsPreferenceButtonClicked {
	
}

- (void)emailPreferenceButtonClicked {
	
}

- (void)appSettingsButtonClicked {
	
}

@end
