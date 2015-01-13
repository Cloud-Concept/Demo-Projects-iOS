//
//  SuperQuestionViewController.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveyQuestion;
@class RequestWrapper;

@protocol SurveyQuestionViewProtocol <NSObject>

- (NSString*) getQuestionAnswer;
- (NSString*) getQuestionAnswerWeight;
- (NSString*) getQuestionAnswerColor;
- (BOOL) isQuestionAnswered;

@end

@interface SuperQuestionViewController : UIViewController


@property (nonatomic, strong) id <SurveyQuestionViewProtocol> child;
@property (nonatomic, strong) SurveyQuestion *surveyQuestion;
@property (nonatomic) NSInteger currentQuestionIndex;
@property (nonatomic, strong) RequestWrapper *requestWrapper;
@property (nonatomic, strong) NSBundle *localeBundle;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) IBOutlet UITextField *questionNumberTextView;
@property (strong, nonatomic) IBOutlet UIImageView *questionTextBackground;
@property (strong, nonatomic) IBOutlet UITextView *questionRightTextView;
@property (strong, nonatomic) IBOutlet UITextField *questionNumberRightTextView;
@property (strong, nonatomic) IBOutlet UILabel *footerTextLabel;

@property (strong, nonatomic) IBOutlet UIImageView *firstBullet;
@property (strong, nonatomic) IBOutlet UIImageView *lastBullet;
@property (strong, nonatomic) IBOutlet UIView *timeLineView;

- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)previousButtonClicked:(id)sender;
- (IBAction)afzLogoClicked:(id)sender;

- (BOOL)isLastQuestion;
//- (void)initChildControlsVisibility;
+ (id)getViewContollerForQuestionWithIndex:(NSInteger)questionIndex;

@end
