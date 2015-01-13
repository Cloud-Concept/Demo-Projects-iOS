//
//  TodoListTableViewCell.h
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoListItem.h"

@interface TodoListTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *todoPriorityImageView;
@property (nonatomic, strong) IBOutlet UILabel *todoPriorityTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *todoTextLabel;

-(void)setPriority:(TodoPriority)priority;

@end
