//
//  EmployeeServicesViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/12/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeServicesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *employeeVisasView;
@property (strong, nonatomic) IBOutlet UIView *issueCretificatesLettersView;
@property (strong, nonatomic) IBOutlet UIView *accessPassesCardsView;
@property (strong, nonatomic) IBOutlet UIView *issueNOCsView;
@property (strong, nonatomic) IBOutlet UIView *dependentVisitVisasView;

- (id)initEmployeeServicesViewController;

@end
