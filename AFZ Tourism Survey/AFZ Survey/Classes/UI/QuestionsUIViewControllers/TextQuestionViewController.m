//
//  TextQuestionViewController.m
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "TextQuestionViewController.h"
#import "RequestWrapper.h"
#import "HelperClass.h"

@interface TextQuestionViewController ()

@end

@implementation TextQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    super.child = self;
    
    [self.answerTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.answerTextView.layer setBorderWidth:2];
    [self.answerTextView.layer setCornerRadius:5];
    [self.answerTextView setClipsToBounds:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    BOOL isRTL = [[HelperClass getSurveyLanguage] isEqualToString:@"Arabic"];
    if (isRTL) {
        self.answerTextView.textAlignment = NSTextAlignmentRight;
    }
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
    
    self.scrollViewOffset = self.scrollView.contentOffset;
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.scrollView.frame = newBiddingViewFrame;
    
    CGRect textFieldRect = [self.answerTextView frame];
    //textFieldRect.origin.y += 10;
    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];
    
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
    
    self.scrollView.frame = self.view.bounds;
    
    // Reset the scrollview to previous location
    self.scrollView.contentOffset = self.scrollViewOffset;
    
    [UIView commitAnimations];
}

-(void) dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma SurveyQuestionViewProtocol
-(NSString*) getQuestionAnswer
{
    return self.answerTextView.text;
}

-(NSString*) getQuestionAnswerColor
{
    return @"";
}

-(NSString*) getQuestionAnswerWeight
{
    return @"5";
}

-(BOOL) isQuestionAnswered
{
    if([self.answerTextView.text length] == 0) { //string is empty or nil
        return NO;
    }
    
    if(![[self.answerTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return NO;
    }
    
    return YES;
}

@end
