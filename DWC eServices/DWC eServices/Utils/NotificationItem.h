//
//  NotificationItem.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationItem : NSObject

@property (nonatomic, strong) NSString *notificationImageURL;
@property (nonatomic, strong) NSString *notificationText;

- (id)initNotificationItem;
- (id)initNotificationItemWithText:(NSString*)text imageURL:(NSString*)imageURL;

@end
