//
//  ViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderUIViewController.h"
#import "HomepageUIViewController.h"
#import "LeftPanelUIViewController.h"
#import "EmployeesViewController.h"


@class CompanyServicesViewController;
@class EmployeeServicesViewController;
@class VisaRenewalViewController;
@class CompanyViewController;

@interface BaseViewController : UIViewController <HeaderViewDelegate, HomepageViewDelegate, LeftPanelViewDelegate, EmployeesViewDelegate>

@property (nonatomic, strong) HeaderUIViewController *headerUIViewController;
@property (nonatomic, strong) LeftPanelUIViewController *leftPanelUIViewController;
@property (nonatomic) HomepageUIViewController *homepageUIViewController;
@property (nonatomic) CompanyServicesViewController *companyServicesViewController;
@property (nonatomic) EmployeeServicesViewController *employeeServicesViewController;
@property (nonatomic) EmployeesViewController *employeesViewController;
@property (nonatomic) VisaRenewalViewController *visaRenewalViewController;
@property (nonatomic) CompanyViewController *companyViewController;

@property (strong, nonatomic) IBOutlet UIView *headerContainerView;
@property (strong, nonatomic) IBOutlet UIView *leftPanelContainerView;
@property (strong, nonatomic) IBOutlet UIView *contentContainerView;

@end
