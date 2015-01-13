//
//  HelperClass.m
//  DWCSurveyTest
//
//  Created by Mina Zaklama on 2/10/14.
//  Copyright (c) 2014 ZAPP Island. All rights reserved.
//

#import "HelperClass.h"
#import "SurveyQuestion.h"
#import "RequestWrapper.h"
#import "Reachability.h"
#import "AppDelegate.h"

static NSMutableArray *_surveyQuestionsArray;
static NSMutableData *_responseData;
static id<SurveyQuestionReadyProtocol> _listener;

@implementation HelperClass

+ (NSArray*) getSurveyQuestions
{
	return  _surveyQuestionsArray;
}

+ (void)initSurveyQuestionsForSurvey:(NSString *)name WithListener:(id<SurveyQuestionReadyProtocol>)listener {
	
	_listener = listener;
	
	_responseData = [[NSMutableData alloc] init];
	
	NSString *urlString = [NSString stringWithFormat:@"%@?SurveyName=%@", kSurveysWebService, name] ;
	
	NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	//Create GET HTTP Method Request
	[request setHTTPMethod:@"GET"];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

+ (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	NSError *error = nil;
	NSArray *_jsonArray = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
	
	_surveyQuestionsArray = [[NSMutableArray alloc] init];
	
	if (error != nil) {
		NSLog(@"Error parsing JSON.");
	}
	else {
		NSLog(@"Array: %@", _jsonArray);
		
		for (NSDictionary *questionDict in _jsonArray) {
			NSString *questionId = [questionDict objectForKey:@"Id"];
			NSString *questionText = [questionDict objectForKey:@"Question__c"];
			NSString *choicesString = [questionDict objectForKey:@"Choices__c"];
			NSString *questionTypeString = [questionDict objectForKey:@"Type__c"];
			BOOL isRequired = (BOOL)[questionDict objectForKey:@"Required__c"];
			NSString *questionSurveyId = [questionDict objectForKey:@"Survey__c"];
			
			NSArray *questionOptions = [choicesString componentsSeparatedByString:@"\r\n"];
			
			QuestionType questionType;
			if ([questionTypeString rangeOfString:@"Single Select"].location != NSNotFound)
				questionType = SingleSelect;
			else if ([questionTypeString rangeOfString:@"Free Text"].location != NSNotFound)
				questionType = Text;
			
			SurveyQuestion *tempQuestion = [[SurveyQuestion alloc] initWithId:questionId AndQuestionText:questionText andType:questionType AndOptions:questionOptions AndRequired:isRequired  AndSurveyId:questionSurveyId];
			
			[_surveyQuestionsArray addObject:tempQuestion];
		}
	}
	
	[_listener surveyQuestionsReady];
	
}

+ (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"error - read error object for details");
}

+ (void)submitSurvey:(RequestWrapper*) requestWrapper
{
	NSURL *url = [NSURL URLWithString:kSurveysWebService];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	//Create POST HTTP Method Request
	[request setHTTPMethod:@"POST"];
	
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObject:[requestWrapper getWrapperToConvertToJSON] forKey:@"requestWrapper"]	options:0 error:&error];
	
	[request setHTTPBody:jsonData];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	if (((AppDelegate*)[[UIApplication sharedApplication] delegate]).isReachable)
		[[NSURLConnection alloc] initWithRequest:request delegate:nil];
	else
	{
		NSString *surveysPlistPath = [[NSBundle mainBundle] pathForResource: @"UnsubmittedSurveys" ofType: @"plist"];
		
		NSMutableArray *surveysDataArray = [NSMutableArray arrayWithContentsOfFile:surveysPlistPath];
		
		[surveysDataArray addObject:jsonData];
		[surveysDataArray writeToFile:surveysPlistPath atomically:YES];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"No internet connection detected. Survey will be submitted when connected." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[alert show];
		
		//Save survey for later to submit
	}
}

+ (void)submitUnsubmittedSurveys
{
	NSString *surveysPlistPath = [[NSBundle mainBundle] pathForResource: @"UnsubmittedSurveys" ofType: @"plist"];
	
	NSMutableArray *surveysDataArray = [NSMutableArray arrayWithContentsOfFile:surveysPlistPath];
	
	for (NSData *surveyData in surveysDataArray) {
		NSURL *url = [NSURL URLWithString:kSurveysWebService];
		
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
		
		[request setHTTPMethod:@"POST"];
		[request setHTTPBody:surveyData];
		[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		[[NSURLConnection alloc] initWithRequest:request delegate:nil];
	}
	
	surveysDataArray = [[NSMutableArray alloc] init];
	[surveysDataArray writeToFile:surveysPlistPath atomically:YES];
}

+ (void)copyFileToDocuments:(NSString*) fileName
{
	BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *databasePath = [homeDir stringByAppendingPathComponent:fileName];
    
	success = [fileManager fileExistsAtPath:databasePath];
    
	if(success) {
        NSLog(@"file found in Documents folder");
        return;
	}
    else {
		NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
		[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
		NSLog(@"file not found in Documents folder.\nCopied to documents folder.");
	}
}

@end
