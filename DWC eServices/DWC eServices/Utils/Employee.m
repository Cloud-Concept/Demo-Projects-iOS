//
//  Employee.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/15/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (id)initEmployee {
	return [self initEmployeeName:@"" Position:@"" Nationality:@"" VisaExpiry:[NSDate date] ImageURL:@""];
}

- (id)initEmployeeName:(NSString*)name Position:(NSString*)position Nationality:(NSString*)nationality VisaExpiry:(NSDate*)visaExpiryDate ImageURL:(NSString*)imageURL {
	
	if (!(self = [super init]))
		return nil;
	
	self.employeeName = name;
	self.employeePosition = position;
	self.employeeNationality = nationality;
	self.employeeVisaExpiryDate = visaExpiryDate;
	self.employeeImageURL = imageURL;
	
	return self;
	
}

- (NSString*)getEmployeeVisaExpiryDateFormatted {
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd yyyy"];//Sept 4 2015
    return [dateFormat stringFromDate:self.employeeVisaExpiryDate];
}

@end
