//
//  HeaderUIViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsPopoverViewController.h"

@protocol HeaderViewDelegate <NSObject>

- (void)headerViewHomeButtonClicked;
- (void)headerViewEmployeesButtonClicked;
- (void)headerViewCompanyButtonClicked;
- (void)headerViewLeasesButtonClicked;
- (void)headerViewServiceHistoryButtonClicked;
- (void)headerViewPaymentsButtonClicked;
@optional
- (void)headerViewSettingsButtonClicked;
- (void)headerViewNotificationsButtonClicked;

@end

@interface HeaderUIViewController : UIViewController <SettingsPopoverDelegate>

typedef enum {
	Home,
	Employees,
	Company,
	Leases,
	ServiceHistory,
	Payments
	
} ApplicationTab;

@property (nonatomic, weak) id <HeaderViewDelegate> delegate;
@property (nonatomic) ApplicationTab activeTab;
@property (strong, nonatomic) NSString *customerName;

@property (strong, nonatomic) UIPopoverController *settingsPopover;
@property (strong, nonatomic) UIPopoverController *notificationsPopover;

@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *employeesButton;
@property (strong, nonatomic) IBOutlet UIButton *companyButton;
@property (strong, nonatomic) IBOutlet UIButton *leasesButton;
@property (strong, nonatomic) IBOutlet UIButton *serviceHistoryButton;
@property (strong, nonatomic) IBOutlet UIButton *paymentsButton;
@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UIButton *notificationsButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


- (id)initWithActiveTab:(ApplicationTab)tab customerName:(NSString*) name;
- (IBAction)homeButtonClicked:(id)sender;
- (IBAction)employeesButtonClicked:(id)sender;
- (IBAction)companyButtonClicked:(id)sender;
- (IBAction)leasesButtonClicked:(id)sender;
- (IBAction)serviceHistoryButtonClicked:(id)sender;
- (IBAction)paymentsButtonClicked:(id)sender;
- (IBAction)settingsButtonClicked:(id)sender;
- (IBAction)notificationsButtonClicked:(id)sender;
- (BOOL)toggleTabActivation:(ApplicationTab)newTab;
- (void)setCustomerNameText:(NSString *)customerName;

@end
