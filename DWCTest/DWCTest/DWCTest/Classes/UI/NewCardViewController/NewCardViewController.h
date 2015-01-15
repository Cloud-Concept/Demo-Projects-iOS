//
//  NewCardViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/23/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"
#import "SFPickListViewController.h"

@class WebForm;
@class EServiceAdministration;

@interface NewCardViewController : UIViewController <SFRestDelegate, SFPickListViewDelegate, UIPopoverControllerDelegate>
{
    NSArray *cardTypesValuesArray;
    NSArray *cardTypesDescriptionsArray;
    
    NSMutableArray *durationArray;
    
    WebForm *currentWebForm;
    NSArray *documentsArray;
    
    NSString *selectedServiceID;
    
    NSString *caseRecordTypeId;
    NSMutableDictionary *cardManagementRecordTypesDictionary;
    
    NSString *selectedCardManagementRecordType;
    
    NSString *insertedCaseId;
    NSString *insertedCardId;
}

@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSNumber *accountBalance;

@property (nonatomic, strong) NSString *selectedCardType;
@property (nonatomic, strong) NSString *selectedDuration;

@property (nonatomic, strong) NSString *operationType;

@property (strong, nonatomic) UIPopoverController *selectCardTypePopover;
@property (strong, nonatomic) UIPopoverController *selectDurationPopover;
@property (strong, nonatomic) UIPopoverController *attachmentsPopover;

@property (weak, nonatomic) IBOutlet UIButton *attachmentsButton;
@property (weak, nonatomic) IBOutlet UIButton *selectCardTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDurationButton;
@property (weak, nonatomic) IBOutlet UIView *dynamicView;
@property (weak, nonatomic) IBOutlet UITextField *feesTextView;


- (IBAction)selectCardTypeButtonClicked:(id)sender;
- (IBAction)selectDurationButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)attachmentButtonClicked:(id)sender;

@end
