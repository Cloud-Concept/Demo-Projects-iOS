//
//  HomeScreenViewController.m
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "RequestWrapper.h"
#import "SuperQuestionViewController.h"
#import "AppDelegate.h"


@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.requestWrapper = [[RequestWrapper alloc] init];
    self.buttonLabelOneEnglish.font = [UIFont fontWithName:@"RopaSans-Regular" size:21];
    self.buttonLabelOneEnglish.textColor = [UIColor whiteColor];
    self.buttonLabelTwoEnglish.font = [UIFont fontWithName:@"RopaSans-Regular" size:25];
    self.buttonLabelTwoEnglish.textColor = [UIColor whiteColor];
    
    self.buttonLabelOneArabic.font = [UIFont fontWithName:@"RopaSans-Regular" size:21];
    self.buttonLabelOneArabic.textColor = [UIColor whiteColor];
    self.buttonLabelTwoArabic.font = [UIFont fontWithName:@"RopaSans-Regular" size:25];
    self.buttonLabelTwoArabic.textColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeAndStartActivityIndicatorSpinner
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.loadingView setHidden:NO];
}

- (void)stopActivityIndicatorSpinner
{
    [self.loadingView setHidden:YES];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (IBAction)startSurveyEnglishClicked:(id)sender {
    [self initializeAndStartActivityIndicatorSpinner];
    [HelperClass initSurveyQuestionsWithListener:self AndLanguage:@"English"];
}

- (IBAction)startSurveyArabicClicked:(id)sender {
    [self initializeAndStartActivityIndicatorSpinner];
    [HelperClass initSurveyQuestionsWithListener:self AndLanguage:@"Arabic"];
}


#pragma mark SurveyQuestionReadyProtocol
- (void)surveyQuestionsReady
{
    [self stopActivityIndicatorSpinner];
    
    if ([[HelperClass getSurveyQuestions] count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"no_questions_error_title", nil) message:NSLocalizedString(@"no_questions_error_msg", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    SuperQuestionViewController *nextView = [SuperQuestionViewController getViewContollerForQuestionWithIndex:0];
    
    nextView.currentQuestionIndex =  0;
    nextView.requestWrapper = [[RequestWrapper alloc] initWithRequestWrapper:self.requestWrapper];
    
    [self.navigationController pushViewController:nextView animated:YES];
}

- (void) surveyQuestionsSyncNoInternetFound {
    [self stopActivityIndicatorSpinner];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't update list of companies. Error contacting server, please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

@end
