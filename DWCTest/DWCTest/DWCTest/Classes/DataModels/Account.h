//
//  Account.h
//  DWCTest
//
//  Created by Mina Zaklama on 1/12/15.
//  Copyright (c) 2015 CloudConcept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *billingCity;
@property (nonatomic, strong) NSString *billingCountryCode;
@property (nonatomic, strong) NSNumber *accountBalance;

- (id)initAccount:(NSString*)AccountId Name:(NSString*)Name BillingCity:(NSString*)BillingCity BillingCountryCode:(NSString*)BillingCountryCode;

- (id)initAccount:(NSString*)AccountId Name:(NSString*)Name AccountBalance:(NSNumber*)AccountBalance;

@end
