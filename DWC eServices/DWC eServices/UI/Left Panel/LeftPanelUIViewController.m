//
//  LeftPanelUIViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 5/28/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "LeftPanelUIViewController.h"
#import "HelperClass.h"

@interface LeftPanelUIViewController ()

@end

@implementation LeftPanelUIViewController

- (id)initLeftPanelViewController
{
    self = [super initWithNibName:@"LeftPanelUIViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[HelperClass createRoundBorderedViewWithShadows:self.leftPanelRoundedView];
	[self.companyNameButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"Aramex DWC LLC"] forState:UIControlStateNormal];
	[self.creditBalanceButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"AED45,999 (Recharge Now)"] forState:UIControlStateNormal];
	[self.visaStatusButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"3 out of 12 available"] forState:UIControlStateNormal];
	[self.licenseRenewalButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"12 June 2014 (Renew Now)"] forState:UIControlStateNormal];
	[self.totalEmployeesButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"20"] forState:UIControlStateNormal];
	
	[self.currentMonthCompletedTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"13 out of 20"] forState:UIControlStateNormal];
	[self.currentMonthInProcessTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"3 out of 20"] forState:UIControlStateNormal];
	[self.currentMonthWaitingApprovalButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"2 out of 20"] forState:UIControlStateNormal];
	[self.currentMonthCancelledTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"1 out of 20"] forState:UIControlStateNormal];
	
	[self.overallCompletedTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"13 out of 20"] forState:UIControlStateNormal];
	[self.overallInProcessTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"3 out of 20"] forState:UIControlStateNormal];
	[self.overallWaitingApprovalButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"2 out of 20"] forState:UIControlStateNormal];
	[self.overallCancelledTransactionsButton setAttributedTitle:[HelperClass createUnderlinedWhiteColorString:@"1 out of 20"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)totalEmployeesButtonClicked:(id)sender {
	[self.delegate totalEmployeesButtonClicked];
}

- (IBAction)companyButtonClicked:(id)sender {
	[self.delegate companyButtonClicked];
}

@end
