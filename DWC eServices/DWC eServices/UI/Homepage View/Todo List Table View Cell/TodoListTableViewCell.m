//
//  TodoListTableViewCell.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/16/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "TodoListTableViewCell.h"

@implementation TodoListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPriority:(TodoPriority)priority {
	NSString *imageName;
	
	switch (priority) {
		case SuperUrgent:
			imageName = @"Todo List Red Button Background";
			self.todoPriorityTextLabel.text = @"Super Urgent";
			break;
		case Urgent:
			imageName = @"Todo List Orange Button Background";
			self.todoPriorityTextLabel.text = @"Urgent";
			break;
		case NotNow:
			imageName = @"Todo List Blue Button Background";
			self.todoPriorityTextLabel.text = @"Not Now";
			break;
		case Easy:
			imageName = @"Todo List Green Button Background";
			self.todoPriorityTextLabel.text = @"Easy";
			break;
		default:
			break;
	}
	
	UIImage *image = [UIImage imageNamed:imageName];
	UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 6.0, 0.0, 0.0);
	
	self.todoPriorityImageView.image = [image resizableImageWithCapInsets:insets];
}

@end
