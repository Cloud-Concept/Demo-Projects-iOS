//
//  EmployeesViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/12/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeesCollectionViewCell.h"

@protocol EmployeesViewDelegate <NSObject>

- (void)employeeVisaRenewalSelected;

@end

@interface EmployeesViewController : UIViewController <UICollectionViewDataSource, EmployeesCollectionViewCellDelegate>

@property (nonatomic, weak) id <EmployeesViewDelegate> delegate;

@property (nonatomic, strong) IBOutlet UICollectionView *employeesCollectionView;
@property (nonatomic, strong) IBOutlet UILabel *totalEmployeesNumberLabel;

@property (nonatomic, strong) NSMutableArray *employeesArray;

- (id)initEmployeesViewController;

@end
