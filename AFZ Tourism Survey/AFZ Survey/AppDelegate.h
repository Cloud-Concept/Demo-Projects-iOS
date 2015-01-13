//
//  AppDelegate.h
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/22/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;
@class CustomIOS7AlertView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CustomIOS7AlertView *_customAlertView;
}

@property (nonatomic, strong) NSString *surveyOwner;
@property (nonatomic) BOOL synchronizeSurvey;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reachability;


@end

