//
//  SettingsPopoverViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/10/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsPopoverDelegate <NSObject>

- (void)manageUsersButtonClicked;
- (void)smsPreferenceButtonClicked;
- (void)emailPreferenceButtonClicked;
- (void)appSettingsButtonClicked;

@end

@interface SettingsPopoverViewController : UIViewController

@property (nonatomic, weak) id <SettingsPopoverDelegate> delegate;

- (id)initSettingsPopoverViewController;

- (IBAction)manageUsersButtonClicked:(id)sender;
- (IBAction)smsPreferenceButtonClicked:(id)sender;
- (IBAction)emailPreferenceClicked:(id)sender;
- (IBAction)appSettingsButtonClicked:(id)sender;
@end
