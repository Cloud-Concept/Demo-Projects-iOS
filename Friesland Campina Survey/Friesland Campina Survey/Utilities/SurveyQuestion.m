//
//  SurveyQuestion.m
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/11/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import "SurveyQuestion.h"

@implementation SurveyQuestion

- (id) initWithQuestion:(NSString*)text andType:(QuestionType)type andOptions:(NSArray*)options
{
	if (!(self = [super init]))
		return nil;
	
	self.questionText = text;
	self.questionOptionsArray = options;
	self.questionType = type;
	
	return self;
}

- (id) initWithId:(NSString*)Id AndQuestionText:(NSString*)text andType:(QuestionType)type AndOptions:(NSArray*)options AndRequired:(BOOL)required AndSurveyId:(NSString*) surveyId
{
	if (!(self = [super init]))
		return nil;
	
	self.questionId = Id;
	self.questionText = text;
	self.questionOptionsArray = options;
	self.questionType = type;
	self.isRequired = required;
	self.questionSurveyId = surveyId;
	
	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	SurveyQuestion *copy = [[[self class] allocWithZone:zone] init];
	copy.questionId = [_questionId copyWithZone:zone];
	copy.questionText = [_questionText copyWithZone:zone];
	copy.questionOptionsArray = [_questionOptionsArray copyWithZone:zone];
	copy.questionType = _questionType;
	copy.isRequired = _isRequired;
	
	return copy;
}

@end
