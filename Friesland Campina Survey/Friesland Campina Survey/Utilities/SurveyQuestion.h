//
//  SurveyQuestion.h
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/11/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyQuestion : NSObject <NSCopying>

typedef enum {
    Text,
	SingleSelect
} QuestionType;

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *questionText;
@property (nonatomic, strong) NSArray *questionOptionsArray;
@property (nonatomic) QuestionType questionType;
@property (nonatomic) BOOL isRequired;
@property (nonatomic, strong) NSString *questionSurveyId;

- (id) initWithQuestion:(NSString*)text andType:(QuestionType)type andOptions:(NSArray*)options;

- (id) initWithId:(NSString*)Id AndQuestionText:(NSString*)text andType:(QuestionType)type AndOptions:(NSArray*)options AndRequired:(BOOL)required AndSurveyId:(NSString*) surveyId;

@end
