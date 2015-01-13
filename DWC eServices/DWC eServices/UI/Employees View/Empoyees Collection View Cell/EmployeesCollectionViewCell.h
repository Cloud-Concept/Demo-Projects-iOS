//
//  EmployeesCollectionViewCell.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/14/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmployeesCollectionViewCellDelegate <NSObject>

-(void)visaRenewalButtonClickedForIndexPath:(NSIndexPath*)indexPath;
-(void)nocButtonClickedForIndexPath:(NSIndexPath*)indexPath;
-(void)accessCardButtonClickedForIndexPath:(NSIndexPath*)indexPath;

@end

@interface EmployeesCollectionViewCell : UICollectionViewCell <UIActionSheetDelegate>

@property (weak) id<EmployeesCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIImageView *employeeImageView;
@property (nonatomic, strong) IBOutlet UILabel *employeeNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *employeePositionLabel;
@property (nonatomic, strong) IBOutlet UILabel *employeeNationalityLabel;
@property (nonatomic, strong) IBOutlet UILabel *employeeVisaExpiryDateLabel;
@property (nonatomic, strong) IBOutlet UIButton *applyButton;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) UIActionSheet *applyActionSheet;

- (void)applyButtonClicked:(id)sender;

@end
