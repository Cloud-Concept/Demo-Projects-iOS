//
//  TodoListItem.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoListItem : NSObject

typedef enum {
	SuperUrgent,
	Urgent,
	NotNow,
	Easy
	
} TodoPriority;

@property (nonatomic) TodoPriority todoPriority;
@property (nonatomic, strong) NSString *todoText;

- (id)initTodoListItem;
- (id)initTodoListItemWithText:(NSString*)text priority:(TodoPriority)priority;

@end
