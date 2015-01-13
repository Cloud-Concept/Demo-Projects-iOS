//
//  EmployeeServicesViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/12/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "EmployeeServicesViewController.h"
#import "HelperClass.h"

@interface EmployeeServicesViewController ()

@end

@implementation EmployeeServicesViewController

- (id)initEmployeeServicesViewController
{
    self = [super initWithNibName:@"EmployeeServicesViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[HelperClass createRoundBorderedViewWithShadows:self.employeeVisasView];
	[HelperClass createRoundBorderedViewWithShadows:self.issueCretificatesLettersView];
	[HelperClass createRoundBorderedViewWithShadows:self.accessPassesCardsView];
	[HelperClass createRoundBorderedViewWithShadows:self.issueNOCsView];
	[HelperClass createRoundBorderedViewWithShadows:self.dependentVisitVisasView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
