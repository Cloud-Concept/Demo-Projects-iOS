//
//  CustomActionPickerView.h
//  Sawahi
//
//  Created by Mina Zaklama on 1/21/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomActionPickerDelegate

@end

@interface CustomActionPickerView : NSObject <UIPickerViewDelegate>
{
	
}

@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) id<CustomActionPickerDelegate> delegate;
@property (nonatomic, strong) NSArray *pickerSourceArray;
@property (nonatomic, strong) NSString *actionPickerViewTitle;
@property (nonatomic, strong) UIView *actionPickerView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSObject *selfReference;

- (id)initWithTargetView:(UIView*)target delegate:(id<CustomActionPickerDelegate>)delegate title:(NSString*)title pickerSourceArray:(NSArray*)sourceArray;
- (void)showActionPicker;
- (void)createActionPickerView;
- (IBAction)actionPickerViewDone:(id)sender;
- (IBAction)actionPickerViewCancel:(id)sender;

@end
