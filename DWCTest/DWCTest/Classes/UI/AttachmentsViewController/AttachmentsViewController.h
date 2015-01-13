//
//  AttachmentsViewController.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/30/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPickListViewController.h"

@class EServiceDocument;

@interface AttachmentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SFPickListViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property BOOL newMedia;
@property (strong, nonatomic) UIViewController *containerViewController;
@property (strong, nonatomic) EServiceDocument *currentSelectedDocument;

@property (strong, nonatomic) NSArray *attachmentsNamesArray;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) UIPopoverController *chooseAttachmentSourcePopover;

@property (weak, nonatomic) IBOutlet UITableView *attachmentsTableView;
@end
