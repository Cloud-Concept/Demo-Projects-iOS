//
//  EmployeesCollectionViewCell.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/14/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "EmployeesCollectionViewCell.h"

@interface EmployeesCollectionViewCell ()

@end

@implementation EmployeesCollectionViewCell


-(id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EmployeesCollectionViewCell" owner:self options:nil];
		
        if ([arrayOfViews count] < 1) {
            return nil;
        }
		
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
		
        self = [arrayOfViews objectAtIndex:0];
		self.employeeImageView = (UIImageView*)[self viewWithTag:10];
		self.employeeNameLabel = (UILabel*)[self viewWithTag:20];
		self.employeePositionLabel = (UILabel*)[self viewWithTag:30];
		self.employeeNationalityLabel = (UILabel*)[self viewWithTag:40];
		self.employeeVisaExpiryDateLabel = (UILabel*)[self viewWithTag:50];
		self.applyButton = (UIButton*)[self viewWithTag:60];
		
		[self.applyButton addTarget:self action:@selector(applyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		
		self.employeeImageView.image = [UIImage imageNamed:@"Default Profile Image"];
		
    }
	
    return self;
}

-(void)applyButtonClicked:(id)sender {
	
	[self.applyActionSheet showFromRect:self.applyButton.frame inView:self animated:YES];
}

- (UIActionSheet *)applyActionSheet {
	
	if([_applyActionSheet isVisible])
		return _applyActionSheet;
	
	_applyActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Visa Renewal", @"NOC", @"Access Card", nil];
	
	_applyActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	
	return _applyActionSheet;
}

#pragma mark - UIActionSheetDelegate delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0: // Visa Renewal
			[self.delegate visaRenewalButtonClickedForIndexPath:self.indexPath];
			break;
		case 1: // NOC
			[self.delegate nocButtonClickedForIndexPath:self.indexPath];
			break;
		case 2: //Access card
			[self.delegate accessCardButtonClickedForIndexPath:self.indexPath];
			break;
	}
}

@end
