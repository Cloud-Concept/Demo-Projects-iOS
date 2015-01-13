//
//  HelperClass.h
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/10/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kSurveysWebService @"https://dev-frieslandcampaigna.cs17.force.com/SurveysServices/services/apexrest/surveys_webservice"
#define kSurveyAccountsWebservice @"https://dev-frieslandcampaigna.cs17.force.com/SurveysServices/services/apexrest/survey_accounts_webservice"

@class RequestWrapper;

@protocol SurveyQuestionReadyProtocol <NSObject>
- (void) surveyQuestionsReady;
@end

@interface HelperClass : NSObject


+ (NSArray*) getSurveyQuestions;
+ (void)initSurveyQuestionsForSurvey:(NSString*) name WithListener:(id<SurveyQuestionReadyProtocol>) listener;
+ (void)submitSurvey:(RequestWrapper*) requestWrapper;
+ (void)submitUnsubmittedSurveys;
+ (void)copyFileToDocuments:(NSString*) fileName;

@end
