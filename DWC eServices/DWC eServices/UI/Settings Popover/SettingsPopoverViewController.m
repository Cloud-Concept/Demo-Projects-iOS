//
//  SettingsPopoverViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/10/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "SettingsPopoverViewController.h"

@interface SettingsPopoverViewController ()

@end

@implementation SettingsPopoverViewController

- (id)initSettingsPopoverViewController
{
    self = [super initWithNibName:@"SettingsPopoverViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)manageUsersButtonClicked:(id)sender {
	[self.delegate manageUsersButtonClicked];
}

- (IBAction)smsPreferenceButtonClicked:(id)sender {
	[self.delegate smsPreferenceButtonClicked];
}

- (IBAction)emailPreferenceClicked:(id)sender {
	[self.delegate emailPreferenceButtonClicked];
}

- (IBAction)appSettingsButtonClicked:(id)sender {
	[self.delegate appSettingsButtonClicked];
}

@end
