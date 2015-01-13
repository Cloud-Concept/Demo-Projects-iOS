//
//  Employee.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/15/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

@property (nonatomic, strong) NSString *employeeImageURL;
@property (nonatomic, strong) NSString *employeeName;
@property (nonatomic, strong) NSString *employeePosition;
@property (nonatomic, strong) NSString *employeeNationality;
@property (nonatomic, strong) NSDate *employeeVisaExpiryDate;

- (id)initEmployee;
- (id)initEmployeeName:(NSString*)name Position:(NSString*)position Nationality:(NSString*)nationality VisaExpiry:(NSDate*)visaExpiryDate ImageURL:(NSString*)imageURL;
- (NSString*)getEmployeeVisaExpiryDateFormatted;

@end
