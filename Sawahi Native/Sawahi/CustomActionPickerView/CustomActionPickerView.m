//
//  CustomActionPickerView.m
//  Sawahi
//
//  Created by Mina Zaklama on 1/21/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "CustomActionPickerView.h"

@implementation CustomActionPickerView

-(id)initWithTargetView:(UIView*)target delegate:(id<CustomActionPickerDelegate>)delegate title:(NSString *)title pickerSourceArray:(NSArray *)sourceArray
{
    if (!(self = [super init]))
		return nil;
		
	self.targetView = target;
	self.delegate = delegate;
	self.actionPickerViewTitle = title;
	self.pickerSourceArray = sourceArray;
	
	//To be able to call the selector on the toolbar buttons.
	//self gets released, here we retain it by another reference to not get released
	self.selfReference = self;
	
	[self createActionPickerView];
	
    return self;
}

- (void)createActionPickerView
{
	self.actionPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.targetView.frame.size.width, 260)];
	
	//Create Toolbar
	CGRect frame = CGRectMake(0, 0, self.targetView.frame.size.width, 44);
    UIToolbar *actionPickerToolbar = [[UIToolbar alloc] initWithFrame:frame];
    actionPickerToolbar.barStyle = UIBarStyleBlackOpaque;
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
	
	//Create Cancel button and Add it to buttons array
	[toolbarItems addObject:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(actionPickerViewCancel:)]];
	
	//Create flexible space
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	//Add flexible space after cancel button
    [toolbarItems addObject:flexibleSpace];
	
	//Create button for Title
	UILabel *toolBarTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180,30)];
    [toolBarTitle setTextAlignment:UITextAlignmentCenter];
    [toolBarTitle setTextColor:[UIColor whiteColor]];
    [toolBarTitle setFont:[UIFont boldSystemFontOfSize:16]];
    [toolBarTitle setBackgroundColor:[UIColor clearColor]];
    toolBarTitle.text = self.actionPickerViewTitle;
	
	//Add Title button to buttons array
	[toolbarItems addObject:[[UIBarButtonItem alloc]initWithCustomView:toolBarTitle]];
	
	//Add flexible space after title
	[toolbarItems addObject:flexibleSpace];
	
	//Create Done button and Add it to buttons array
	[toolbarItems addObject:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(actionPickerViewDone:)]];
	
	//Set toolbar buttons
    [actionPickerToolbar setItems:toolbarItems animated:YES];
	
	[actionPickerToolbar setBarStyle:UIBarStyleBlackTranslucent];
	[actionPickerToolbar setTranslucent:YES];
	
	//Create PickerView
	CGRect pickerFrame = CGRectMake(0, 40, self.targetView.frame.size.width, 216);
    UIPickerView *pv = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pv.delegate = self;
    pv.showsSelectionIndicator = YES;
	
	[self.actionPickerView addSubview:pv];
	
	//Add Toolbar to actionPickerView
	[self.actionPickerView addSubview:actionPickerToolbar];
}

- (void)showActionPicker
{	
	self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [self.actionSheet addSubview:self.actionPickerView];
    
	[self.actionSheet showInView:self.targetView];
    
	//self.actionSheet.bounds = self.actionPickerView.frame;
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
	
	CGRect rect = self.actionPickerView.frame;
	rect.size.height = 480;
	self.actionSheet.bounds = rect;
	
    [UIView commitAnimations];
}

- (IBAction)actionPickerViewDone:(id)sender {

	[self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)actionPickerViewCancel:(id)sender {
	
	[self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;// or the number of vertical "columns" the picker will show...
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	//this will tell the picker how many rows it has - in this case, the size of your loaded array...
    return [self.pickerSourceArray count];//[self.pickerSourceArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	//you can also write code here to descide what data to return depending on the component ("column")
	return [self.pickerSourceArray objectAtIndex:row];//or nil, depending how protective you are
}
@end
