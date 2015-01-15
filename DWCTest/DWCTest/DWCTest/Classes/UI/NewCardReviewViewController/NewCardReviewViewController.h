//
//  NewCardReviewViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 1/5/15.
//  Copyright (c) 2015 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@class WebForm;

@interface NewCardReviewViewController : UIViewController <SFRestDelegate>

@property (strong, nonatomic) NSString *caseId;
@property (strong, nonatomic) WebForm *currentWebForm;

@property (weak, nonatomic) IBOutlet UITextField *requestNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestStatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestCreatedDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *requestTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;
@property (weak, nonatomic) IBOutlet UIView *dynamicView;


- (IBAction)payAndSubmitButtonClicked:(id)sender;
@end
