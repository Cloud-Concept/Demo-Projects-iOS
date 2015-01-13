//
//  LicenseRenewalViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/15/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "VisaRenewalViewController.h"
#import "HelperClass.h"

@interface VisaRenewalViewController ()

@end

@implementation VisaRenewalViewController

- (id)initVisaRenewalViewController
{
    self = [super initWithNibName:@"VisaRenewalViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self.viewPassportCopyButton setAttributedTitle:[HelperClass createUnderlinedString:@"View Passport Copy" color:[UIColor colorWithRed:0.098f green:0.435f blue:0.666f alpha:1]] forState:UIControlStateNormal];
	[self.uploadNewCopyButton setAttributedTitle:[HelperClass createUnderlinedString:@"Upload New Copy" color:[UIColor colorWithRed:0.098f green:0.435f blue:0.666f alpha:1]] forState:UIControlStateNormal];
	
	
	UIImage *image = [UIImage imageNamed:@"Visa Renewal Header Background"];
	UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 6.0, 0.0, 6.0);
	
	self.visaRenewalHeaderImageView.image = [image resizableImageWithCapInsets:insets];
	
	[HelperClass createRoundBorderedViewWithShadows:self.visaRenewalRoundedView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
