//
//  HelperClass.h
//  DWCTest
//
//  Created by Mina Zaklama on 12/8/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestAPI.h"

@class WebForm;

@interface HelperClass : NSObject

+ (NSDate*)dateTimeFromString:(NSString*)dateStringValue;
+ (NSString*)stringCheckNull:(NSString*)stringValue;
+ (NSNumber*)numberCheckNull:(NSNumber*)numberValue;
+ (NSString*)getRelationshipValue:(NSDictionary*)dictionary Key:(NSString*)key;
+ (void)drawFormFields:(WebForm*)currentWebForm DynamicView:(UIView*)dynamicView;
+ (void)removeFormFields:(UIView*)dynamicView;
+ (void)createCompanyDocuments:(NSString*) parentID ParentField:(NSString*)parentField Document:(NSArray*)documentsArray CompanyID:(NSString*)companyId;
+ (void)callPayAndSubmitWebservice:(NSString*)caseId Delegate:(id<SFRestDelegate>)delegate;

@end
