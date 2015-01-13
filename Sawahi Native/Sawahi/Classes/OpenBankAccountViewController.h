//
//  OpenBankAccountViewController.h
//  Sawahi
//
//  Created by Mina Zaklama on 1/20/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionPickerView.h"

@interface OpenBankAccountViewController : UIViewController <CustomActionPickerDelegate>

@property (strong, nonatomic) IBOutlet UIView *courierDetailsUIView;
@property (strong, nonatomic) IBOutlet UIScrollView *openBankAccountUIScrollView;

- (IBAction)nextButtonTouchUpInside:(id)sender;

@end
