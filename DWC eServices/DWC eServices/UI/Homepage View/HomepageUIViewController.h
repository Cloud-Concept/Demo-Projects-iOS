//
//  HomepageUIViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 5/27/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomepageViewDelegate <NSObject>

- (void)logisticsServicesButtonClicked;
- (void)leasingServicesButtonClicked;
- (void)companyServicesButtonClicked;
- (void)employeeServicesButtonClicked;

@end

@interface HomepageUIViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, weak) id <HomepageViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *notificationsArray;
@property (nonatomic, strong) NSMutableArray *todosArray;

@property (strong, nonatomic) IBOutlet UIView *logisticsServicesView;
@property (strong, nonatomic) IBOutlet UIView *leasingServicesView;
@property (strong, nonatomic) IBOutlet UIView *companyServicesView;
@property (strong, nonatomic) IBOutlet UIView *employeeServicesView;
@property (strong, nonatomic) IBOutlet UITableView *notificationsTableView;
@property (strong, nonatomic) IBOutlet UITableView *todoTableView;

- (id)initHomepageUIViewController;
- (IBAction)logisticsServicesButtonClicked:(id)sender;
- (IBAction)leasingServicesButtonClicked:(id)sender;
- (IBAction)companyServicesButtonClicked:(id)sender;
- (IBAction)employeeServicesButtonClicked:(id)sender;

@end
