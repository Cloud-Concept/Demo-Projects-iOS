//
//  CompanyViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "CompanyViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initCompanyViewController
{
    self = [super initWithNibName:@"CompanyViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	UIImage *image = [UIImage imageNamed:@"Company Background"];
	UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 6.0, 0.0, 6.0);
	
	self.companyInformationBackgroungImageView.image = [image resizableImageWithCapInsets:insets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)companyInformationTabButtonClicked:(id)sender {
	[self toggleTabActivation:CompanyInformationTab];
}

- (IBAction)licenseInformationTabButtonClicked:(id)sender {
	[self toggleTabActivation:LicenseInformationTab];
}

- (IBAction)directorTabButtonClicked:(id)sender {
	[self toggleTabActivation:DirectorTab];
}

- (IBAction)shareholderTabButtonClicked:(id)sender {
	[self toggleTabActivation:ShareholderTab];
}

- (IBAction)managerInformationTabButtonClicked:(id)sender {
	[self toggleTabActivation:ManagerInformationTab];
}

- (BOOL)toggleTabActivation:(CompanyTab)newTab {
	if (newTab == self.activeTab)
		return NO;
	
	[self deactivateTab:self.activeTab];
	[self activateTab:newTab];
	return YES;
}

- (void)deactivateTab:(CompanyTab)tab {
	switch (tab) {
		case CompanyInformationTab:
			[self.companyInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Inactive Background"] forState:UIControlStateNormal];
			break;
		case LicenseInformationTab:
			[self.licenseInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Inactive Background"] forState:UIControlStateNormal];
			break;
		case DirectorTab:
			[self.directorTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Inactive Background"] forState:UIControlStateNormal];
			break;
		case ShareholderTab:
			[self.shareholderTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Inactive Background"] forState:UIControlStateNormal];
			break;
		case ManagerInformationTab:
			[self.managerInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Inactive Background"] forState:UIControlStateNormal];
			break;
		default:
			break;
	}
}

- (void)activateTab:(CompanyTab)tab {
	switch (tab) {
		case CompanyInformationTab:
			[self.companyInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Active Background"] forState:UIControlStateNormal];
			break;
		case LicenseInformationTab:
			[self.licenseInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Active Background"] forState:UIControlStateNormal];
			break;
		case DirectorTab:
			[self.directorTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Active Background"] forState:UIControlStateNormal];
			break;
		case ShareholderTab:
			[self.shareholderTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Active Background"] forState:UIControlStateNormal];
			break;
		case ManagerInformationTab:
			[self.managerInformationTabButton setBackgroundImage:[UIImage imageNamed:@"Company Tab Button Active Background"] forState:UIControlStateNormal];
			break;
		default:
			break;
	}
	
	self.activeTab = tab;
}


@end
