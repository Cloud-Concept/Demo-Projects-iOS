//
//  EmployeesTableViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 11/25/14.
//  Copyright (c) 2014 Zapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface EmployeesTableViewController : UITableViewController<SFRestDelegate>

@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSNumber *accountBalance;
@property (nonatomic, strong) NSMutableArray *dataRows;

@end
