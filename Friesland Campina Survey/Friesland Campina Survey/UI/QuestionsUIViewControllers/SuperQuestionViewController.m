//
//  SuperQuestionViewController.m
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/11/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import "SuperQuestionViewController.h"
#import "ThankYouViewController.h"
#import "AppDelegate.h"
#import "RequestWrapper.h"
#import "HelperClass.h"
#import "SurveyQuestion.h"

@interface SuperQuestionViewController ()

@end

@implementation SuperQuestionViewController
@synthesize child;

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
	
	self.surveyQuestion = [[HelperClass getSurveyQuestions] objectAtIndex:self.currentQuestionIndex];
	
	self.questionNumberTextView.text = [NSString stringWithFormat:@"Q%d",self.currentQuestionIndex + 1];
	//self.questionTextView.font = [UIFont fontWithName:@"DIN-MediumAlternate" size:70];
	self.questionTextView.font = [UIFont fontWithName:@"RopaSans-Regular" size:70];
	self.questionTextView.textColor = [UIColor whiteColor];
	
	self.questionTextView.text = self.surveyQuestion.questionText;
	//self.questionTextView.font = [UIFont fontWithName:@"Titillium-Semibold" size:22];
	self.questionTextView.font = [UIFont fontWithName:@"RopaSans-Regular" size:22];
	self.questionTextView.textColor = [UIColor whiteColor];
	
	[self.submitButton setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];
	//self.submitButton.titleLabel.font = [UIFont fontWithName:@"BigNoodleTitling" size:44];
	self.submitButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:44];
	self.submitButton.titleLabel.textColor = [UIColor whiteColor];
	
	[self.nextButton setTitle:NSLocalizedString(@"next", nil) forState:UIControlStateNormal];
	//self.nextButton.titleLabel.font = [UIFont fontWithName:@"BigNoodleTitling" size:44];
	self.nextButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:44];
	self.nextButton.titleLabel.textColor = [UIColor whiteColor];
	
	[self.previousButton setTitle:@"BACK" forState:UIControlStateNormal];
	//self.previousButton.titleLabel.font = [UIFont fontWithName:@"BigNoodleTitling" size:44];
	self.previousButton.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:44];
	self.previousButton.titleLabel.textColor = [UIColor whiteColor];
	
	self.footerTextLabel.text = NSLocalizedString(@"questions_footer", nil);
	//self.footerTextLabel.font = [UIFont fontWithName:@"Titillium-Light" size:15];
	self.footerTextLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:15];
	self.footerTextLabel.textColor = [UIColor whiteColor];
	
	
	switch (self.currentQuestionIndex) {
		case 0:
			[self.bulletOne setImage:[UIImage imageNamed:@"BlueTimeLineBullet.png"]];
			break;
		case 1:
			[self.bulletTwo setImage:[UIImage imageNamed:@"BlueTimeLineBullet.png"]];
			break;
		case 2:
			[self.bulletThree setImage:[UIImage imageNamed:@"BlueTimeLineBullet.png"]];
			break;
		case 3:
			[self.bulletFour setImage:[UIImage imageNamed:@"BlueTimeLineBullet.png"]];
			break;
		case 4:
			[self.bulletFive setImage:[UIImage imageNamed:@"BlueTimeLineBullet.png"]];
			break;
	}
	
	
	[self initChildControlsVisibility];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initChildControlsVisibility
{
	if ([self isLastQuestion])
	{
		[self.nextButton setHidden:YES];
		
		[self.submitButton setHidden:NO];
	}
	else
	{
		[self.nextButton setHidden:NO];
		
		[self.submitButton setHidden:YES];
	}
}

- (void)showErrorMessgae
{
	NSString *message;
	
	if (self.surveyQuestion.questionType == Text)
	{
		if ([self isLastQuestion])
			message = NSLocalizedString(@"text_error_message_last_question", nil);
		else
			message = NSLocalizedString(@"text_error_message", nil);
	}
	else if (self.surveyQuestion.questionType == SingleSelect)
	{
		if ([self isLastQuestion])
			message = NSLocalizedString(@"single_select_error_message_last_question", nil);
		else
			message = NSLocalizedString(@"single_select_error_message", nil);
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", nil) message:message delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
	[alert show];
}

- (IBAction)submitButtonClicked:(id)sender
{
	if (![child isQuestionAnswered] && self.surveyQuestion.isRequired)
	{
		[self showErrorMessgae];
		return;
	}
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		
	NSString *answer = [child getQuestionAnswer];
	NSDictionary *answerDict = [[NSDictionary alloc] initWithObjects:@[self.surveyQuestion.questionId, answer] forKeys:@[@"Survey_Question__c", @"Response__c"]];
	
	//Adding answer to temp request wrapper before submit.
	RequestWrapper *tempRequestWrapper = [[RequestWrapper alloc] initWithRequestWrapper:self.requestWrapper];
	[tempRequestWrapper.surveyQuestionResponseList addObject:answerDict];
	
	[tempRequestWrapper.surveyTaker setValue:self.surveyQuestion.questionSurveyId forKey:@"Survey__c"];
	
	[HelperClass submitSurvey:tempRequestWrapper];
	
	ThankYouViewController *thankYouView = [storyBoard instantiateViewControllerWithIdentifier:@"ThankYouViewController"];
	
	[self.navigationController pushViewController:thankYouView animated:YES];
}

- (IBAction)nextButtonClicked:(id)sender
{
	if (![child isQuestionAnswered] && self.surveyQuestion.isRequired)
	{
		[self showErrorMessgae];
		return;
	}
	
	NSString *answer = [child getQuestionAnswer];
	
	NSDictionary *answerDict = [[NSDictionary alloc] initWithObjects:@[self.surveyQuestion.questionId, answer] forKeys:@[@"Survey_Question__c", @"Response__c"]];
	
	//Adding answer to temp request wrapper before submit.
	RequestWrapper *tempRequestWrapper = [[RequestWrapper alloc] initWithRequestWrapper:self.requestWrapper];
	[tempRequestWrapper.surveyQuestionResponseList addObject:answerDict];
	
	//Call super class to view next question
	SuperQuestionViewController *nextQuestionView = [SuperQuestionViewController getViewContollerForQuestionWithIndex:self.currentQuestionIndex + 1];
	
	nextQuestionView.currentQuestionIndex = self.currentQuestionIndex + 1;
	nextQuestionView.requestWrapper = tempRequestWrapper;
	
	[self.navigationController pushViewController:nextQuestionView animated:YES];
}

- (IBAction)previousButtonClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isLastQuestion
{
	return !(self.currentQuestionIndex < [[HelperClass getSurveyQuestions] count] - 1);
}

+ (id)getViewContollerForQuestionWithIndex:(NSInteger)questionIndex
{
	if(questionIndex >= [[HelperClass getSurveyQuestions] count])
		return nil;
	
	SurveyQuestion *question = [[HelperClass getSurveyQuestions] objectAtIndex:questionIndex];
	
	NSString *controllerStoryBoardId;
	
	switch (question.questionType) {
		case Text:
			controllerStoryBoardId = @"TextViewQuestionControllerID";
			break;
			
		case SingleSelect:
			controllerStoryBoardId = @"PickerViewQuestionControllerID";
			break;
	}
	
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	SuperQuestionViewController *nextQuestionView = (SuperQuestionViewController*)[storyBoard instantiateViewControllerWithIdentifier:controllerStoryBoardId];
	
	return nextQuestionView;
}


@end
