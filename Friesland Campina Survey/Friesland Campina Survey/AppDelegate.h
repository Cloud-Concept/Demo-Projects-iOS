//
//  AppDelegate.h
//  Friesland Campina Survey
//
//  Created by Mina Zaklama on 3/16/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reachability;
@property (nonatomic) BOOL isReachable;
@property (nonatomic, strong) NSString *counterNumber;
@property (nonatomic, strong) NSString *surveyName;
@end
