//
//  OpenBankAccountViewController.m
//  Sawahi
//
//  Created by Mina Zaklama on 1/20/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "OpenBankAccountViewController.h"
#import "CustomActionPickerView.h"

@interface OpenBankAccountViewController ()
@property CGPoint scrollViewContentOffset;
@end

@implementation OpenBankAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.navigationItem.title = NSLocalizedString(@"open_bank_account", nil);
	
	_courierDetailsUIView.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	// Register for the events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma KeyBoard Notifications
-(void) keyboardDidShow: (NSNotification *)notif {
	NSDictionary *userInfo = [notif userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
    // Get the top of the keyboard as the y coordinate of its origin in self's view's
    // coordinate system. The bottom of the text view's frame should align with the top
    // of the keyboard's final position.
    //
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newBiddingViewFrame = self.view.bounds;
    newBiddingViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
	
	// Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
	
	self.scrollViewContentOffset = self.openBankAccountUIScrollView.contentOffset;
	
	// Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.openBankAccountUIScrollView.frame = newBiddingViewFrame;
	
	//CGRect textFieldRect = [self.orderedTricksUITextField frame];
    //textFieldRect.origin.y += 10;
    //[self.openBankAccountUIScrollView scrollRectToVisible:textFieldRect animated:YES];
	
    [UIView commitAnimations];
}

-(void) keyboardDidHide: (NSNotification *)notif {
	NSDictionary *userInfo = [notif userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.openBankAccountUIScrollView.frame = self.view.bounds;
    
	// Reset the scrollview to previous location
    self.openBankAccountUIScrollView.contentOffset = self.scrollViewContentOffset;
	
    [UIView commitAnimations];
}

- (IBAction)nextButtonTouchUpInside:(id)sender {
	/* Animate view hide and show
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_courierDetailsUIView cache:YES];
	
    _courierDetailsUIView.frame = CGRectMake(_courierDetailsUIView.frame.origin.x, _courierDetailsUIView.frame.origin.y, _courierDetailsUIView.frame.size.width, 0);

    [UIView commitAnimations];
	*/
	
	CustomActionPickerView *actionPicker = [[CustomActionPickerView alloc] initWithTargetView:self.view delegate:self title:@"TestTile" pickerSourceArray:@[@"Item 1", @"Item 2", @"Item 3"]];
	
	[actionPicker showActionPicker];
	
}

@end
