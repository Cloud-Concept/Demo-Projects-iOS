//
//  CompanyServicesViewController.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/11/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyServicesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *amendmentView;
@property (strong, nonatomic) IBOutlet UIView *licensingView;
@property (strong, nonatomic) IBOutlet UIView *officialDocumentRequestView;
@property (strong, nonatomic) IBOutlet UIView *shareholdersView;
@property (strong, nonatomic) IBOutlet UIView *directorChairpersonSecretaryView;
@property (strong, nonatomic) IBOutlet UIView *managersView;
@property (strong, nonatomic) IBOutlet UIView *establishmentCardView;

- (id)initCompanyServicesViewController;

@end
