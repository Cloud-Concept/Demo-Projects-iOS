//
//  LicenseRenewalViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/15/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisaRenewalViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *visaRenewalRoundedView;
@property (nonatomic, strong) IBOutlet UIImageView *visaRenewalHeaderImageView;
@property (strong, nonatomic) IBOutlet UIButton *viewPassportCopyButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadNewCopyButton;

- (id)initVisaRenewalViewController;

@end
