//
//  TextQuestionViewController.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import "SuperQuestionViewController.h"

@interface TextQuestionViewController : SuperQuestionViewController  <SurveyQuestionViewProtocol>

@property (nonatomic) CGPoint scrollViewOffset;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextView *answerTextView;

@end
