//
//  SingleSelectQuestionViewController.m
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "SingleSelectQuestionViewController.h"
#import "RequestWrapper.h"
#import "SurveyQuestion.h"
#import "HelperClass.h"

@interface SingleSelectQuestionViewController ()

@end

@implementation SingleSelectQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    super.child = self;
    
    self.selectedOptionIndex = -1;
    
    self.optionsSourceArray = [super surveyQuestion].questionOptionsArray;
    
    if([[HelperClass getSurveyLanguage] isEqualToString:@"English"])
        self.optionsSourceDisplayArray = [super surveyQuestion].questionOptionsArray;
    else
        self.optionsSourceDisplayArray = [super surveyQuestion].questionOptionsArrayArabic;
    
    /*
    [self setButtonStyle:self.optionOneButton];
    [self setButtonStyle:self.optionTwoButton];
    [self setButtonStyle:self.optionThreeButton];
    
    if([self.optionsSourceDisplayArray count] > 3)
    {
        [self setButtonStyle:self.optionFourButton];
        [self setButtonStyle:self.optionFiveButton];
    }
    */
    
    [self.optionOneButton setTitle:[self.optionsSourceDisplayArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.optionTwoButton setTitle:[self.optionsSourceDisplayArray objectAtIndex:1] forState:UIControlStateNormal];
    if([self.optionsSourceDisplayArray count] > 2)
    {
        [self.optionThreeButton setTitle:[self.optionsSourceDisplayArray objectAtIndex:2] forState:UIControlStateNormal];
    }
    else
    {
        self.optionThreeButton.hidden = YES;
    }
    
    if([self.optionsSourceDisplayArray count] > 3)
    {
        [self.optionFourButton setTitle:[self.optionsSourceDisplayArray objectAtIndex:3] forState:UIControlStateNormal];
        
        if ([self.optionsSourceDisplayArray count] == 5)
        {
            
            [self.optionFiveButton setTitle:[self.optionsSourceDisplayArray objectAtIndex:4] forState:UIControlStateNormal];
        }
        else
        {
            self.optionFiveButton.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)optionSelected:(id)sender
{
    UIButton *selectedButton = (UIButton*)sender;
    
    if (self.selectedOptionIndex == selectedButton.tag)
        return;
    
    switch (self.selectedOptionIndex) {
        case 0:
            [self.optionOneButton setSelected:NO];
            break;
        case 1:
            [self.optionTwoButton setSelected:NO];
            break;
        case 2:
            [self.optionThreeButton setSelected:NO];
            break;
        case 3:
            [self.optionFourButton setSelected:NO];
            break;
        case 4:
            [self.optionFiveButton setSelected:NO];
            break;
        default:
            break;
    }
    
    self.selectedOptionIndex = selectedButton.tag;
    
    switch (self.selectedOptionIndex) {
        case 0:
            [self.optionOneButton setSelected:YES];
            break;
        case 1:
            [self.optionTwoButton setSelected:YES];
            break;
        case 2:
            [self.optionThreeButton setSelected:YES];
            break;
        case 3:
            [self.optionFourButton setSelected:YES];
            break;
        case 4:
            [self.optionFiveButton setSelected:YES];
            break;
        default:
            break;
    }
}

- (void)setButtonStyle:(UIButton*)button
{
    //button.titleLabel.font = [UIFont fontWithName:@"DIN-RegularAlternate" size:22];
    button.titleLabel.font = [UIFont fontWithName:@"RopaSans-Regular" size:22];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"BlueOptionBackground"] forState:UIControlStateSelected];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"GrayOptionBackground"] forState:UIControlStateNormal];
}

#pragma SurveyQuestionViewProtocol
- (NSString*) getQuestionAnswer
{
    return [self.optionsSourceArray objectAtIndex:self.selectedOptionIndex];
}

- (NSString*) getQuestionAnswerColor
{
    if([[super surveyQuestion].questionOptionsColorArray count] > 0)
        return [[super surveyQuestion].questionOptionsColorArray objectAtIndex:self.selectedOptionIndex];
    else
        return @"";
}

- (NSString*) getQuestionAnswerWeight
{
    if([[super surveyQuestion].questionOptionsWeightArray count] > 0)
        return [[super surveyQuestion].questionOptionsWeightArray objectAtIndex:self.selectedOptionIndex];
    else
        return @"";
}

- (BOOL) isQuestionAnswered
{
    return self.selectedOptionIndex > -1;
}

@end
