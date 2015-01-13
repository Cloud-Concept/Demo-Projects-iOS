//
//  HomeScreenViewController.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/25/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelperClass.h"

@interface HomeScreenViewController : UIViewController <SurveyQuestionReadyProtocol>

@property (strong, nonatomic) IBOutlet UILabel *buttonLabelOneEnglish;
@property (strong, nonatomic) IBOutlet UILabel *buttonLabelTwoEnglish;

@property (strong, nonatomic) IBOutlet UILabel *buttonLabelOneArabic;
@property (strong, nonatomic) IBOutlet UILabel *buttonLabelTwoArabic;
@property (strong, nonatomic) IBOutlet UIView *loadingView;

@property (nonatomic, strong) RequestWrapper *requestWrapper;

- (IBAction)startSurveyEnglishClicked:(id)sender;
- (IBAction)startSurveyArabicClicked:(id)sender;

@end
