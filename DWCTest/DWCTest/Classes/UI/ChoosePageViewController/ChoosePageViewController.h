//
//  ChoosePageViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePageViewController : UIViewController

@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSNumber *accountBalance;

- (IBAction)employeesButtonClicked:(id)sender;
- (IBAction)nonEmployeesButtonClicked:(id)sender;
- (IBAction)newCardButtonClicked:(id)sender;

@end
