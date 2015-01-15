//
//  NonEmployeesTableViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"
#import "SFPickListViewController.h"

@class CardManagement;

@interface NonEmployeesTableViewController : UITableViewController<SFRestDelegate, SFPickListViewDelegate>
{
    CardManagement *selectedCard;
}
@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSNumber *accountBalance;
@property (nonatomic, strong) NSMutableArray *dataRows;
@property (nonatomic, strong) UIPopoverController *chooseCardPopover;

@end
