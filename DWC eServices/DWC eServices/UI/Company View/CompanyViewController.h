//
//  CompanyViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyViewController : UIViewController

typedef enum {
	CompanyInformationTab,
	LicenseInformationTab,
	DirectorTab,
	ShareholderTab,
	ManagerInformationTab
} CompanyTab;

@property (nonatomic) CompanyTab activeTab;

@property (nonatomic, strong) IBOutlet UIImageView *companyInformationBackgroungImageView;
@property (nonatomic, strong) IBOutlet UIButton *companyInformationTabButton;
@property (nonatomic, strong) IBOutlet UIButton *licenseInformationTabButton;
@property (nonatomic, strong) IBOutlet UIButton *directorTabButton;
@property (nonatomic, strong) IBOutlet UIButton *shareholderTabButton;
@property (nonatomic, strong) IBOutlet UIButton *managerInformationTabButton;

- (id)initCompanyViewController;
- (IBAction)companyInformationTabButtonClicked:(id)sender;
- (IBAction)licenseInformationTabButtonClicked:(id)sender;
- (IBAction)directorTabButtonClicked:(id)sender;
- (IBAction)shareholderTabButtonClicked:(id)sender;
- (IBAction)managerInformationTabButtonClicked:(id)sender;
- (BOOL)toggleTabActivation:(CompanyTab)newTab;

@end
