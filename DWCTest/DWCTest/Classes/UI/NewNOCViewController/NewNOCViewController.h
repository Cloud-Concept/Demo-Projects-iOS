//
//  NewNOCViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 11/26/14.
//  Copyright (c) 2014 Zapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"
#import "SFPickListViewController.h"

@class WebForm;
@class EServiceAdministration;

@interface NewNOCViewController : UIViewController <SFRestDelegate, SFPickListViewDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate>
{
    NSString *NOCRecordTypeId;
    NSString *underProcessRecordTypeId;
    WebForm *currentWebForm;
    
    NSString *insertedCaseId;
    NSString *insertedNOCId;
    
    EServiceAdministration *selectedServiceAdmin;
}

@property (nonatomic, strong) NSMutableArray *dataRows;

@property (strong, nonatomic) NSNumber *accountBalance;
@property (strong, nonatomic) NSString *accountId;
@property (strong, nonatomic) NSString *employeeId;
@property (strong, nonatomic) NSString *visaId;
@property (strong, nonatomic) NSString *employeeName;
@property (strong, nonatomic) NSString *passportNumber;
@property (strong, nonatomic) NSString *passportCountry;
@property (strong, nonatomic) NSString *visaNumber;
@property (strong, nonatomic) NSString *languageSelected;
@property (strong, nonatomic) NSString *nocIDSeleted;
@property (strong, nonatomic) NSString *nocNameSelected;
@property (strong, nonatomic) NSString *billingCity;
@property (strong, nonatomic) NSString *billingCountry;

@property (strong, nonatomic) UIPopoverController *chooseNOCPopover;
@property (strong, nonatomic) UIPopoverController *attachmentsPopover;

@property (strong, nonatomic) IBOutlet UIButton *chooseNOCButton;
@property (strong, nonatomic) IBOutlet UISwitch *courierSwitch;
@property (strong, nonatomic) IBOutlet UITextField *nocChargesTextField;
@property (strong, nonatomic) IBOutlet UITextField *courierCorpRateTextView;
@property (strong, nonatomic) IBOutlet UITextField *courierRetailRateTextView;
@property (strong, nonatomic) IBOutlet UIView *dynamicView;
@property (weak, nonatomic) IBOutlet UIButton *attachmentsButton;

- (IBAction)chooseNOCButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)attachmentsButtonClicked:(id)sender;

@end
