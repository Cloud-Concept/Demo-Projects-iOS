//
//  HomepageUIViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 5/27/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "HomepageUIViewController.h"
#import "NotificationTableViewCell.h"
#import "NotificationItem.h"
#import "TodoListTableViewCell.h"
#import "HelperClass.h"

@interface HomepageUIViewController ()

@end

@implementation HomepageUIViewController

- (id)initHomepageUIViewController {
	self = [super initWithNibName:@"HomepageUIViewController" bundle:nil];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[HelperClass createRoundBorderedViewWithShadows:self.employeeServicesView];
	[HelperClass createRoundBorderedViewWithShadows:self.companyServicesView];
	[HelperClass createRoundBorderedViewWithShadows:self.leasingServicesView];
	[HelperClass createRoundBorderedViewWithShadows:self.logisticsServicesView];
	
	[self initNotificationsData];
	[self initTodosData];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.notificationsTableView reloadData];
	[self.todoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logisticsServicesButtonClicked:(id)sender {
	[self.delegate logisticsServicesButtonClicked];
}

- (IBAction)leasingServicesButtonClicked:(id)sender {
	[self.delegate leasingServicesButtonClicked];
}

- (IBAction)companyServicesButtonClicked:(id)sender {
	[self.delegate companyServicesButtonClicked];
}

- (IBAction)employeeServicesButtonClicked:(id)sender {
	[self.delegate employeeServicesButtonClicked];
}

- (UITableViewCell *)notificationTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
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

- (UITableViewCell *)todoListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"TodoListTableViewCell";
	
	TodoListItem *todoListItem = [self.todosArray objectAtIndex:indexPath.row % [self.todosArray count]];
	
    TodoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(!cell) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TodoListTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
	
	[cell setPriority:todoListItem.todoPriority];
	cell.todoTextLabel.text = todoListItem.todoText;
	
    return cell;
	
}

- (void)initNotificationsData {
	self.notificationsArray = [[NSMutableArray alloc] init];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Abigail Johnson"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"\"Headphones trouble shooting\" - Tim Services" imageURL:@"Charles Winston"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"Wetex" imageURL:@"Marissa Mayer"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Nihonjin No Shimei"]];
	
	[self.notificationsArray addObject:[[NotificationItem alloc] initNotificationItemWithText:@"00001022 - Ely East to DWC Only" imageURL:@"Charles Winston"]];
}

- (void)initTodosData {
	self.todosArray = [[NSMutableArray alloc] init];
	
	[self.todosArray addObject:[[TodoListItem alloc] initTodoListItemWithText:@"00001022 - Ely East to DWC only" priority:SuperUrgent]];
	
	[self.todosArray addObject:[[TodoListItem alloc] initTodoListItemWithText:@"\"Headphones trouble shooting\" - Tim Services" priority:Urgent]];
	
	[self.todosArray addObject:[[TodoListItem alloc] initTodoListItemWithText:@"Wetex" priority:NotNow]];
	
	[self.todosArray addObject:[[TodoListItem alloc] initTodoListItemWithText:@"00001022 - Ely East to DWC only\nAttached an.." priority:Easy]];
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
	NSInteger count = 0;
	if (tableView == self.notificationsTableView)
		count =  [self.notificationsArray count] * 3;
	else if (tableView == self.todoTableView)
		count = [self.todosArray count] * 3;
	
	return count;
		
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	if (tableView == self.notificationsTableView)
		cell = [self notificationTableView:tableView cellForRowAtIndexPath:indexPath];
	else if (tableView == self.todoTableView)
		cell = [self todoListTableView:tableView cellForRowAtIndexPath:indexPath];
	else
		cell = nil;
	
	return cell;
}


@end
