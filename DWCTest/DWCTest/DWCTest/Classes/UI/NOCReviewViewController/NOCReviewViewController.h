//
//  NOCReviewViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/31/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@class WebForm;

@interface NOCReviewViewController : UIViewController <SFRestDelegate>

@property (strong, nonatomic) NSString *caseId;
@property (strong, nonatomic) WebForm *currentWebForm;

@property (weak, nonatomic) IBOutlet UITextField *requestNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestCreatedDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestStatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *nocTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *languageTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalChargesTextField;
@property (weak, nonatomic) IBOutlet UISwitch *requiredCourierSwitch;
@property (weak, nonatomic) IBOutlet UIView *dynamicVIew;

- (IBAction)payAndSubmitButtonClicked:(id)sender;
@end
