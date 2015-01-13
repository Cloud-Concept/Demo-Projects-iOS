//
//  LoginViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/12/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "LoginViewController.h"
#import "HelperClass.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[HelperClass createRoundBorderedViewWithShadows:self.loginView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
