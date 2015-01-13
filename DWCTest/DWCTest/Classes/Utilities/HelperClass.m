//
//  HelperClass.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/8/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "HelperClass.h"
#import "FormField.h"
#import "WebForm.h"
#import "EServiceDocument.h"
#import "SFRestAPI+Blocks.h"

@implementation HelperClass

+ (NSDate*)dateTimeFromString:(NSString*)dateStringValue {
    dateStringValue = [HelperClass stringCheckNull:dateStringValue];
    
    if ([dateStringValue isEqualToString:@""]) {
        return [NSDate date];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    dateStringValue = [dateStringValue stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dateStringValue = [dateStringValue substringToIndex:[dateStringValue rangeOfString:@"."].location];
    
    return [format dateFromString:dateStringValue];
}

+ (NSString*)stringCheckNull:(NSString*)stringValue {
    if(![stringValue isKindOfClass:[NSNull class]])
        return stringValue;
    else
        return @"";
}

+ (NSNumber*)numberCheckNull:(NSNumber*)numberValue {
    if(![numberValue isKindOfClass:[NSNull class]])
        return numberValue;
    else
        return 0;
}

+ (NSString*)getRelationshipValue:(NSDictionary*)dictionary Key:(NSString*)key {
    if ([key containsString:@"."]) {
        //NSArray *keyValue = [key componentsSeparatedByString:@"."];
        //NSDictionary *newDictionary = [dictionary objectForKey:[keyValue objectAtIndex:0]];
        //NSString *newKey = [keyValue objectAtIndex:1];
        
        NSRange range = [key rangeOfString:@"."];
        NSDictionary *newDictionary = [dictionary objectForKey:[key substringToIndex:range.location]];
        NSString *newKey = [key substringFromIndex:range.location + 1];
        
        return [HelperClass getRelationshipValue:newDictionary Key:newKey];
    }
    else
        return [dictionary objectForKey:key];
    
}

+ (void)drawFormFields:(WebForm*)currentWebForm DynamicView:(UIView*)dynamicView {
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary new];
    
    for (FormField *field in currentWebForm.formFields) {
        [viewsDictionary setObject:[field getFieldView] forKey:field.name];
        [viewsDictionary setObject:[field getLabelView] forKey:[NSString stringWithFormat:@"%@_label", field.name]];
        [field getFieldView].translatesAutoresizingMaskIntoConstraints = NO;
        [field getLabelView].translatesAutoresizingMaskIntoConstraints = NO;
        [dynamicView addSubview:[field getFieldView]];
        [dynamicView addSubview:[field getLabelView]];
    }
    
    for (NSInteger index = 0; index < [currentWebForm.formFields count]; index++) {
        
        FormField *currentField = [currentWebForm.formFields objectAtIndex:index];
        FormField *previousField = nil;
        
        if (currentField.hidden)
            continue;
        
        NSString *heightRule = [NSString stringWithFormat:@"V:[%@(44)]", currentField.name];
        NSArray *field_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:heightRule
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
        
        NSString *widthtRule = [NSString stringWithFormat:@"H:[%@(100)]", currentField.name];
        NSArray *field_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:widthtRule
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
        
        [dynamicView addConstraints:field_constraint_V];
        //[self.dynamicView addConstraints:field_constraint_H];
        
        NSString *labelName = [NSString stringWithFormat:@"%@_label", currentField.name];
        
        NSString *labelHeightRule = [NSString stringWithFormat:@"V:[%@(44)]", labelName];
        NSArray *label_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:labelHeightRule
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
        
        NSString *labelWidthtRule = [NSString stringWithFormat:@"H:[%@(200)]", labelName];
        NSArray *label_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:labelWidthtRule
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
        
        [dynamicView addConstraints:label_constraint_V];
        [dynamicView addConstraints:label_constraint_H];
        
        if(index != 0)
            previousField = [currentWebForm.formFields objectAtIndex:index - 1];
        
        NSString *horizontalRule = [NSString stringWithFormat:@"H:|-[%@]-[%@]-|", labelName, currentField.name];
        NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:horizontalRule
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
        
        NSMutableString *verticalRule = [NSMutableString stringWithString:@"V:"];
        NSMutableString *verticalLabelRule = [NSMutableString stringWithString:@"V:"];
        
        if (previousField == nil)
        {
            [verticalRule appendFormat:@"|-"];
            [verticalLabelRule appendString:@"|-"];
        }
        else
        {
            [verticalRule appendFormat:@"[%@]-", previousField.name];
            [verticalLabelRule appendFormat:@"[%@]-", [NSString stringWithFormat:@"%@_label", previousField.name]];
        }
        
        [verticalRule appendFormat:@"[%@]", currentField.name];
        [verticalLabelRule appendFormat:@"[%@]", labelName];
        
        NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:verticalRule
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
        
        NSArray *constraint_Label_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:verticalLabelRule
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:viewsDictionary];
        
        [dynamicView addConstraints:constraint_POS_H];
        [dynamicView addConstraints:constraint_POS_V];
        [dynamicView addConstraints:constraint_Label_POS_V];
    }
    
}

+ (void)removeFormFields:(UIView*)dynamicView {
    for (UIView *subView in dynamicView.subviews) {
        [subView removeFromSuperview];
    }
}

+ (void)createCompanyDocuments:(NSString*) parentID ParentField:(NSString*)parentField Document:(NSArray*)documentsArray CompanyID:(NSString*)companyId {
    for (EServiceDocument *doc in documentsArray) {
        NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                                doc.name, @"Name",
                                doc.Id, @"eServices_Document__c",
                                companyId, @"Company__c",
                                parentID, parentField,
                                nil];
        
        void (^successBlock)(NSDictionary *dict) = ^(NSDictionary *dict) {
            NSString *companyDocumentId = [dict objectForKey:@"id"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addAttachment:doc.name ToParent:companyDocumentId DocumentImage:doc.attachment];
            });
        };
        
        void (^errorBlock) (NSError*) = ^(NSError *e) {
        };
        
        [[SFRestAPI sharedInstance] performCreateWithObjectType:@"Company_Documents__c"
                                                         fields:fields
                                                      failBlock:errorBlock
                                                  completeBlock:successBlock];
    }
}

+ (void)addAttachment:(NSString*)documentName ToParent:(NSString*) parentID DocumentImage:(UIImage*)image {
    //UIImage *resizedImage = [HelperClass imageWithImage:image ScaledToSize:CGSizeMake(480, 640)];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *string = [imageData base64EncodedStringWithOptions:0];
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            documentName, @"Name",
                            @"image", @"ContentType",
                            parentID, @"ParentId",
                            string, @"Body",
                            nil];
    SFRestRequest *attachmentRequest = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:@"Attachment" fields:fields];
    
    [[SFRestAPI sharedInstance] send:attachmentRequest delegate:nil];
    
}

+ (void)callPayAndSubmitWebservice:(NSString*)caseId Delegate:(id<SFRestDelegate>)delegate {
    
    // Manually set up request object
    SFRestRequest *payAndSubmitRequest = [[SFRestRequest alloc] init];
    payAndSubmitRequest.endpoint = [NSString stringWithFormat:@"/services/apexrest/MobilePayAndSubmitWebService"];
    payAndSubmitRequest.method = SFRestMethodPOST;
    payAndSubmitRequest.path = @"/services/apexrest/MobilePayAndSubmitWebService";
    payAndSubmitRequest.queryParams = [NSDictionary dictionaryWithObject:caseId forKey:@"caseId"];
    
    [[SFRestAPI sharedInstance] send:payAndSubmitRequest delegate:delegate];
}
@end
