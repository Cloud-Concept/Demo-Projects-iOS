//
//  ContactInfoViewController.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RequestWrapper;

@interface ContactInfoViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) RequestWrapper *requestWrapper;
@property (nonatomic, strong) NSBundle *localeBundle;
@property (nonatomic) CGPoint scrollViewOffset;

@property (strong, nonatomic) IBOutlet UILabel *contactInfoLabel;
@property (strong, nonatomic) IBOutlet UITextField *licenseNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (strong, nonatomic) IBOutlet UILabel *footerTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)afzLogoClicked:(id)sender;
@end
