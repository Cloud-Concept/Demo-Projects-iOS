//
//  NotificationItem.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "NotificationItem.h"

@implementation NotificationItem

- (id)initNotificationItem {
	return [self initNotificationItemWithText:@"" imageURL:@""];
}

- (id)initNotificationItemWithText:(NSString*)text imageURL:(NSString*)imageURL {
	if (!(self = [super init]))
		return nil;
	
	self.notificationText = text;
	self.notificationImageURL = imageURL;
	
	return self;
}

@end
