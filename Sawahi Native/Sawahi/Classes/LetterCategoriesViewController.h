//
//  LetterCategoriesViewController.h
//  Sawahi
//
//  Created by Mina Zaklama on 1/19/14.
//  Copyright (c) 2014 Cloud Concept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterCategoriesViewController : UITableViewController {
    
    NSArray *dataRows;
}

@property (nonatomic, strong) NSArray *dataRows;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
