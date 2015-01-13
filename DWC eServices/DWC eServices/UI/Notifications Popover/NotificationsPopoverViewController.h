//
//  NotificationsPopoverViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/10/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsPopoverViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *notificationsArray;

@property (nonatomic, strong) IBOutlet UITableView *notificationsTableView;

- (id)initSettingsPopoverViewController;

@end
