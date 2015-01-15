//
//  Account.m
//  DWCTest
//
//  Created by Mina Zaklama on 1/12/15.
//  Copyright (c) 2015 CloudConcept. All rights reserved.
//

#import "Account.h"

@implementation Account

- (id)initAccount:(NSString*)AccountId Name:(NSString*)Name BillingCity:(NSString*)BillingCity BillingCountryCode:(NSString*)BillingCountryCode {
    if (!(self = [super init]))
        return nil;
    
    self.Id = AccountId;
    self.name = Name;
    self.billingCity = BillingCity;
    self.billingCountryCode = BillingCountryCode;
    self.accountBalance = [NSNumber numberWithInt:0];
    
    return self;
}

- (id)initAccount:(NSString*)AccountId Name:(NSString*)Name AccountBalance:(NSNumber*)AccountBalance {
    if (!(self = [super init]))
        return nil;
    
    self.Id = AccountId;
    self.name = Name;
    self.accountBalance = AccountBalance;
    self.billingCity = @"";
    self.billingCountryCode = @"";
    
    return self;
}

@end
