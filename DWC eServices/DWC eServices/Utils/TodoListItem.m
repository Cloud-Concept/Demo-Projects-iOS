//
//  TodoListItem.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "TodoListItem.h"

@implementation TodoListItem

- (id)initTodoListItem {
	return [self initTodoListItemWithText:@"" priority:SuperUrgent];
}

- (id)initTodoListItemWithText:(NSString*)text priority:(TodoPriority)priority {
	if (!(self = [super init]))
		return nil;
	
	self.todoText = text;
	self.todoPriority = priority;
	
	return self;
}

@end
