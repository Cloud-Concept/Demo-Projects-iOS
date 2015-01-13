//
//  CompanyServicesViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/11/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "CompanyServicesViewController.h"
#import "HelperClass.h"

@interface CompanyServicesViewController ()

@end

@implementation CompanyServicesViewController

- (id)initCompanyServicesViewController
{
    self = [super initWithNibName:@"CompanyServicesViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[HelperClass createRoundBorderedViewWithShadows:self.amendmentView];
	[HelperClass createRoundBorderedViewWithShadows:self.licensingView];
	[HelperClass createRoundBorderedViewWithShadows:self.officialDocumentRequestView];
	[HelperClass createRoundBorderedViewWithShadows:self.shareholdersView];
	[HelperClass createRoundBorderedViewWithShadows:self.directorChairpersonSecretaryView];
	[HelperClass createRoundBorderedViewWithShadows:self.managersView];
	[HelperClass createRoundBorderedViewWithShadows:self.establishmentCardView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
