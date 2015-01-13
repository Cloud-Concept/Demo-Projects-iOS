//
//  ContactInfoViewController.m
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "HelperClass.h"
#import "RequestWrapper.h"
#import "AppDelegate.h"
#import "ThankYouViewController.h"
#import "NSString+isNumeric.h"

@interface ContactInfoViewController ()

@end

@implementation ContactInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[HelperClass surveyLanguageAbbreviation] ofType:@"lproj"];
    self.localeBundle = [NSBundle bundleWithPath:path];
    
    self.contactInfoLabel.text = NSLocalizedStringFromTableInBundle(@"contact_info_label", nil, self.localeBundle, nil);
    self.licenseNumberTextField.placeholder = NSLocalizedStringFromTableInBundle(@"license_number_placeholder", nil, self.localeBundle, nil);
    self.personNameTextField.placeholder = NSLocalizedStringFromTableInBundle(@"person_name_placeholder", nil, self.localeBundle, nil);
    self.mobileNumberTextField.placeholder = NSLocalizedStringFromTableInBundle(@"mobile_number_placeholder", nil, self.localeBundle, nil);
    self.footerTextLabel.text = NSLocalizedStringFromTableInBundle(@"questions_footer", nil, self.localeBundle, nil);
    
    [self.submitButton setTitle:NSLocalizedStringFromTableInBundle(@"submit", nil, self.localeBundle, nil) forState:UIControlStateNormal];
    
    /*
    BOOL isRTL = [[HelperClass getSurveyLanguage] isEqualToString:@"Arabic"];
    if (isRTL) {
        self.licenseNumberTextField.textAlignment = NSTextAlignmentRight;
        self.personNameTextField.textAlignment = NSTextAlignmentRight;
        self.mobileNumberTextField.textAlignment = NSTextAlignmentRight;
    }
    */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // Register for the events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitButtonClicked:(id)sender {
    
    if (![self validateInput])
    {
        return;
    }
    
    self.requestWrapper.licenseNumber = self.licenseNumberTextField.text;
    [self.requestWrapper.surveyTaker setValue:self.personNameTextField.text forKey:@"Person_Name__c"];
    [self.requestWrapper.surveyTaker setValue:self.mobileNumberTextField.text forKey:@"Person_Mobile_Number__c"];
    [self.requestWrapper.surveyTaker setValue:((AppDelegate*)[UIApplication sharedApplication].delegate).surveyOwner forKey:@"Survey_Owner__c"];
    [self.requestWrapper.surveyTaker setValue:@"iPad Survey" forKey:@"Process_Type__c"];
    [self.requestWrapper.surveyTaker setValue:[HelperClass getSurveyId] forKey:@"Survey__c"];
    
    [HelperClass submitSurvey:self.requestWrapper];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ThankYouViewController *thankYouView = [storyBoard instantiateViewControllerWithIdentifier:@"ThankYouViewController"];
    
    [self.navigationController pushViewController:thankYouView animated:YES];
}

- (IBAction)afzLogoClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)showErrorMessgae
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"error", nil, self.localeBundle, nil) message:NSLocalizedStringFromTableInBundle(@"contact_info_error_message", nil, self.localeBundle, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"ok", nil, self.localeBundle, nil) otherButtonTitles: nil];
    [alert show];
}

- (void)showFieldTypeErrorMessgae
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"error", nil, self.localeBundle, nil) message:NSLocalizedStringFromTableInBundle(@"contact_info_field_type_error_message", nil, self.localeBundle, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"ok", nil, self.localeBundle, nil) otherButtonTitles: nil];
    [alert show];
}

- (BOOL) validateInput {
    
    if (![self.licenseNumberTextField.text isNumeric] ||
        ![self.mobileNumberTextField.text isNumeric]) {
        [self showFieldTypeErrorMessgae];
        return NO;
    }
    
    if([self.licenseNumberTextField.text length] == 0 ||
       [self.personNameTextField.text length] == 0 ||
       [self.mobileNumberTextField.text length] == 0) { //string is empty or nil
        [self showErrorMessgae];
        return NO;
    }
    
    if(![[self.licenseNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ||
       ![[self.personNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ||
       ![[self.mobileNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        [self showErrorMessgae];
        return NO;
    }
    
    return YES;
}

#pragma UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
}

#pragma KeyBoard Notifications
-(void) keyboardDidShow: (NSNotification *)notif {
    
    NSDictionary* info = [notif userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(void) keyboardDidHide: (NSNotification *)notif {
    
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    
    //self.scrollView.frame = self.view.bounds;
    //self.scrollView.contentOffset = self.scrollViewOffset;
}

-(void) dismissKeyboard {
    [self.view endEditing:YES];
}

@end
