//
//  NSString_isNumeric.m
//  AFZ Survey
//
//  Created by Mina Zaklama on 10/29/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSString (isNumeric)

- (BOOL) isAllDigits
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

-(BOOL) isNumeric
{
    NSScanner *sc = [NSScanner scannerWithString: self];
    // We can pass NULL because we don't actually need the value to test
    // for if the string is numeric. This is allowable.
    if ( [sc scanFloat:NULL] )
    {
        // Ensure nothing left in scanner so that "42foo" is not accepted.
        // ("42" would be consumed by scanFloat above leaving "foo".)
        return [sc isAtEnd];
    }
    // Couldn't even scan a float :(
    return NO;
}

@end