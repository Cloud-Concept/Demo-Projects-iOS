//
//  SuperQuestionViewController.h
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/11/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveyQuestion;
@class RequestWrapper;

@protocol SurveyQuestionViewProtocol <NSObject>

- (NSString*) getQuestionAnswer;
- (BOOL) isQuestionAnswered;

@end

@interface SuperQuestionViewController : UIViewController
{
	id <SurveyQuestionViewProtocol> child;
}

@property (nonatomic) id <SurveyQuestionViewProtocol> child;

@property (nonatomic, strong) SurveyQuestion *surveyQuestion;
@property (nonatomic) NSInteger currentQuestionIndex;
@property (nonatomic, strong) RequestWrapper *requestWrapper;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) IBOutlet UITextField *questionNumberTextView;
@property (strong, nonatomic) IBOutlet UILabel *footerTextLabel;

@property (strong, nonatomic) IBOutlet UIImageView *bulletOne;
@property (strong, nonatomic) IBOutlet UIImageView *bulletTwo;
@property (strong, nonatomic) IBOutlet UIImageView *bulletThree;
@property (strong, nonatomic) IBOutlet UIImageView *bulletFour;
@property (strong, nonatomic) IBOutlet UIImageView *bulletFive;


- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)nextButtonClicked:(id)sender;
- (IBAction)previousButtonClicked:(id)sender;

- (BOOL)isLastQuestion;
- (void)initChildControlsVisibility;
+ (id)getViewContollerForQuestionWithIndex:(NSInteger)questionIndex;

@end
