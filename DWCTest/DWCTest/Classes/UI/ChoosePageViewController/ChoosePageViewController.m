//
//  ChoosePageViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "ChoosePageViewController.h"
#import "EmployeesTableViewController.h"
#import "NonEmployeesTableViewController.h"
#import "NewCardViewController.h"

@interface ChoosePageViewController ()

@end

@implementation ChoosePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose Page";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)employeesButtonClicked:(id)sender {
    EmployeesTableViewController *empVC = [EmployeesTableViewController new];
    
    empVC.accountId = self.accountId;
    empVC.accountBalance = self.accountBalance;
    
    [self.navigationController pushViewController:empVC animated:YES];
}

- (IBAction)nonEmployeesButtonClicked:(id)sender {
    NonEmployeesTableViewController *nonEmpVC = [NonEmployeesTableViewController new];
    
    nonEmpVC.accountId = self.accountId;
    nonEmpVC.accountBalance = self.accountBalance;
    
    [self.navigationController pushViewController:nonEmpVC animated:YES];
    
}

- (IBAction)newCardButtonClicked:(id)sender {
    NewCardViewController *newCardVC = [NewCardViewController new];
    
    newCardVC.accountId = self.accountId;
    newCardVC.accountBalance = self.accountBalance;
    
    [self.navigationController pushViewController:newCardVC animated:YES];
}
@end
