//
//  ContactsDetailViewController.h
//  Sawahi
//
//  Created by Mina Zaklama on 1/22/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface ContactsDetailViewController : UIViewController <SFRestDelegate>
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabelField;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabelField;
@property (strong, nonatomic) IBOutlet UILabel *nationalityLabelField;
@property (strong, nonatomic) IBOutlet UILabel *countryOfBirthLabelField;
@property (strong, nonatomic) IBOutlet UILabel *birthDateLabelField;
@property (strong, nonatomic) IBOutlet UILabel *firstNameValueField;
@property (strong, nonatomic) IBOutlet UILabel *lastNameValueField;
@property (strong, nonatomic) IBOutlet UILabel *nationalityValueField;
@property (strong, nonatomic) IBOutlet UILabel *countryOfBirthValueField;
@property (strong, nonatomic) IBOutlet UILabel *birthDateValueField;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, atomic) UIActivityIndicatorView *spinner;

@property (nonatomic, strong) NSArray *dataRows;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *contactName;

@end
