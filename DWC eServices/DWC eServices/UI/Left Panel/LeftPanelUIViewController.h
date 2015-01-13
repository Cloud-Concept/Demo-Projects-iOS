//
//  LeftPanelUIViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 5/28/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftPanelViewDelegate <NSObject>
- (void)totalEmployeesButtonClicked;
- (void)companyButtonClicked;
@end

@interface LeftPanelUIViewController : UIViewController

@property (nonatomic, weak) id <LeftPanelViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *leftPanelRoundedView;
@property (strong, nonatomic) IBOutlet UIButton *companyNameButton;
@property (strong, nonatomic) IBOutlet UIButton *creditBalanceButton;
@property (strong, nonatomic) IBOutlet UIButton *visaStatusButton;
@property (strong, nonatomic) IBOutlet UIButton *licenseRenewalButton;
@property (strong, nonatomic) IBOutlet UIButton *totalEmployeesButton;
@property (strong, nonatomic) IBOutlet UIButton *currentMonthCompletedTransactionsButton;
@property (strong, nonatomic) IBOutlet UIButton *currentMonthInProcessTransactionsButton;
@property (strong, nonatomic) IBOutlet UIButton *currentMonthWaitingApprovalButton;
@property (strong, nonatomic) IBOutlet UIButton *currentMonthCancelledTransactionsButton;
@property (strong, nonatomic) IBOutlet UIButton *overallCompletedTransactionsButton;
@property (strong, nonatomic) IBOutlet UIButton *overallInProcessTransactionsButton;
@property (strong, nonatomic) IBOutlet UIButton *overallWaitingApprovalButton;
@property (strong, nonatomic) IBOutlet UIButton *overallCancelledTransactionsButton;

- (id)initLeftPanelViewController;
- (IBAction)totalEmployeesButtonClicked:(id)sender;
- (IBAction)companyButtonClicked:(id)sender;

@end
