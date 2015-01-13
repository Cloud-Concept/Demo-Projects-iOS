//
//  NotificationsPopoverViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/10/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "NotificationsPopoverViewController.h"
#import "NotificationTableViewCell.h"
#import "NotificationItem.h"

@interface NotificationsPopoverViewController ()

@end

@implementation NotificationsPopoverViewController

- (id)initSettingsPopoverViewController
{
    self = [super initWithNibName:@"NotificationsPopoverViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self initNotificationsData];
	[self.notificationsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNotificationsData {
	self.notificationsArray = [[NSMutableArray alloc] init];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Abigail Johnson"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"\"Headphones trouble shooting\" - Tim Services" imageURL:@"Charles Winston"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"Wetex" imageURL:@"Marissa Mayer"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Nihonjin No Shimei"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Charles Winston"]];
}


#pragma UITableViewDatasource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return [self.notificationsArray count] * 3;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"NotificationTableViewCell";
	
	NotificationItem *notificationItem = [self.notificationsArray objectAtIndex:indexPath.row % [self.notificationsArray count]];
	
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(!cell) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NotificationTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
	
	cell.notificationTextLabel.text = notificationItem.notificationText;
	cell.notificationImageView.image = [UIImage imageNamed:notificationItem.notificationImageURL];
	
    return cell;
}

@end
