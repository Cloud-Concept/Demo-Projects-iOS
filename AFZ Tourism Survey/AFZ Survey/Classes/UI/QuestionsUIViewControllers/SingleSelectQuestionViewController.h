//
//  SingleSelectQuestionViewController.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "SuperQuestionViewController.h"

@interface SingleSelectQuestionViewController : SuperQuestionViewController <SurveyQuestionViewProtocol>

@property (nonatomic, strong) NSArray *optionsSourceArray;
@property (nonatomic, strong) NSArray *optionsSourceDisplayArray;
@property (nonatomic) NSInteger selectedOptionIndex;

@property (strong, nonatomic) IBOutlet UIButton *optionOneButton;
@property (strong, nonatomic) IBOutlet UIButton *optionTwoButton;
@property (strong, nonatomic) IBOutlet UIButton *optionThreeButton;
@property (strong, nonatomic) IBOutlet UIButton *optionFourButton;
@property (strong, nonatomic) IBOutlet UIButton *optionFiveButton;

- (IBAction)optionSelected:(id)sender;
- (void)setButtonStyle:(UIButton*)button;

@end
