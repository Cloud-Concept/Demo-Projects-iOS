//
//  EmployeesViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 6/12/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "EmployeesViewController.h"
#import "Employee.h"
#import "HelperClass.h"

@interface EmployeesViewController ()

@end

@implementation EmployeesViewController

- (id)initEmployeesViewController
{
    self = [super initWithNibName:@"EmployeesViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self.employeesCollectionView registerClass:[EmployeesCollectionViewCell class] forCellWithReuseIdentifier:@"EmployeesCollectionViewCell"];
	
	self.employeesArray = [[NSMutableArray alloc] init];
	
	[self initEmployeesData];
	
	self.totalEmployeesNumberLabel.text = [NSString stringWithFormat:@"%lu", [self.employeesArray count] * 20];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.employeesCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initEmployeesData {
	[self.employeesArray addObject:[[Employee alloc] initEmployeeName:@"Abigail Johnson" Position:@"Senior Sales Executive" Nationality:@"United States of America" VisaExpiry:[HelperClass initDateWithString:@"12/05/2015" dateFormat:@"dd/MM/yyyy"] ImageURL:@"Abigail Johnson"]];
	
	[self.employeesArray addObject:[[Employee alloc] initEmployeeName:@"Charles Winston" Position:@"Group Manager" Nationality:@"Spain" VisaExpiry:[HelperClass initDateWithString:@"22/12/2014" dateFormat:@"dd/MM/yyyy"] ImageURL:@"Charles Winston"]];
	
	[self.employeesArray addObject:[[Employee alloc] initEmployeeName:@"Marissa Mayer" Position:@"HR Manager" Nationality:@"Finland" VisaExpiry:[HelperClass initDateWithString:@"4/09/2015" dateFormat:@"dd/MM/yyyy"] ImageURL:@"Marissa Mayer"]];
	
	[self.employeesArray addObject:[[Employee alloc] initEmployeeName:@"Nihonjin No Shimei" Position:@"Senior Sales Executive" Nationality:@"China" VisaExpiry:[HelperClass initDateWithString:@"25/11/2015" dateFormat:@"dd/MM/yyyy"] ImageURL:@"Nihonjin No Shimei"]];
	
	[self.employeesArray addObject:[[Employee alloc] initEmployeeName:@"Andrew Mason" Position:@"Head of Technical Department" Nationality:@"United States of America" VisaExpiry:[HelperClass initDateWithString:@"1/01/2016" dateFormat:@"dd/MM/yyyy"] ImageURL:@""]];
}

#pragma UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.employeesArray count] * 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"EmployeesCollectionViewCell";
	
    EmployeesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	Employee *currentEmployee = [self.employeesArray objectAtIndex:indexPath.row % [self.employeesArray count]];
	
	if (![currentEmployee.employeeImageURL length] == 0 && [[currentEmployee.employeeImageURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
		cell.employeeImageView.image = [UIImage imageNamed:currentEmployee.employeeImageURL];
	cell.employeeNameLabel.text = currentEmployee.employeeName;
	cell.employeeNationalityLabel.text = currentEmployee.employeeNationality;;
	cell.employeePositionLabel.text = currentEmployee.employeePosition;
	cell.employeeVisaExpiryDateLabel.text = [currentEmployee getEmployeeVisaExpiryDateFormatted];
	cell.indexPath = indexPath;
	cell.delegate = self;
	
    return cell;
}

#pragma EmployeesCollectionViewCellDelegate Methods

-(void)visaRenewalButtonClickedForIndexPath:(NSIndexPath*)indexPath {
	[self.delegate employeeVisaRenewalSelected];
}

-(void)nocButtonClickedForIndexPath:(NSIndexPath*)indexPath {
	
}

-(void)accessCardButtonClickedForIndexPath:(NSIndexPath*)indexPath {
	
}

@end
