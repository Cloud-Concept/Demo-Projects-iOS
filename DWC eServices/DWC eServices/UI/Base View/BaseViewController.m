//
//  ViewController.m
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "BaseViewController.h"

#import "CompanyServicesViewController.h"
#import "EmployeeServicesViewController.h"
#import "VisaRenewalViewController.h"
#import "CompanyViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self) {
		[self initViewControllers];
	}
	return self;
}

- (void)initViewControllers  {	
	self.headerUIViewController = [[HeaderUIViewController alloc] initWithActiveTab:Home customerName:@"Mina Zaklama"];
	self.headerUIViewController.delegate = self;
	
	self.leftPanelUIViewController = [[LeftPanelUIViewController alloc] initLeftPanelViewController];
	self.leftPanelUIViewController.delegate = self;
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.headerContainerView addSubview:self.headerUIViewController.view];
	[self.contentContainerView addSubview:self.homepageUIViewController.view];
	[self.leftPanelContainerView addSubview:self.leftPanelUIViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

- (void)removeContentContainerSubViews {
	for (UIView* subview in self.contentContainerView.subviews)
    {
		[subview removeFromSuperview];
    }
}

- (HomepageUIViewController*)homepageUIViewController {
	if(!_homepageUIViewController) {
		_homepageUIViewController = [[HomepageUIViewController alloc] initHomepageUIViewController];
		_homepageUIViewController.delegate = self;
	}
	return _homepageUIViewController;
}

- (CompanyServicesViewController*)companyServicesViewController {
	if(!_companyServicesViewController) {
		_companyServicesViewController = [[CompanyServicesViewController alloc] initCompanyServicesViewController];
	}
	
	return _companyServicesViewController;
}

- (EmployeeServicesViewController*)employeeServicesViewController {
	if (!_employeeServicesViewController) {
		_employeeServicesViewController = [[EmployeeServicesViewController alloc] initEmployeeServicesViewController];
	}
	
	return _employeeServicesViewController;
	
}

- (EmployeesViewController*)employeesViewController {
	if (!_employeesViewController) {
		_employeesViewController = [[EmployeesViewController alloc] initEmployeesViewController];
		_employeesViewController.delegate = self;
	}
	
	return _employeesViewController;
}

- (VisaRenewalViewController*)visaRenewalViewController {
	if (!_visaRenewalViewController) {
		_visaRenewalViewController = [[VisaRenewalViewController alloc] initVisaRenewalViewController];
	}
	
	return _visaRenewalViewController;
}

- (CompanyViewController*)companyViewController {
	if (!_companyViewController) {
		_companyViewController = [[CompanyViewController alloc] initCompanyViewController];
	}
	return _companyViewController;
}

#pragma HeaderViewDelegate Methods
- (void)headerViewHomeButtonClicked {
	[self removeContentContainerSubViews];
	[self.contentContainerView addSubview:self.homepageUIViewController.view];
}

- (void)headerViewEmployeesButtonClicked {
	[self removeContentContainerSubViews];
	
	[self.contentContainerView addSubview:self.employeesViewController.view];
}

- (void)headerViewCompanyButtonClicked {
	[self removeContentContainerSubViews];
	[self.contentContainerView addSubview:self.companyViewController.view];
}

- (void)headerViewLeasesButtonClicked {
	
}

- (void)headerViewServiceHistoryButtonClicked {
	
}

- (void)headerViewPaymentsButtonClicked {
	
}

#pragma HomeViewDelegate Methods
- (void)logisticsServicesButtonClicked {
	
}

- (void)leasingServicesButtonClicked {
	
}

- (void)companyServicesButtonClicked {
	[self removeContentContainerSubViews];
	
	self.companyServicesViewController.view.frame = CGRectMake(self.companyServicesViewController.view.frame.origin.x, self.companyServicesViewController.view.frame.origin.y, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
	
	[self.contentContainerView addSubview:self.companyServicesViewController.view];
	
	[self.headerUIViewController toggleTabActivation:Company];
}

- (void)employeeServicesButtonClicked {
	[self removeContentContainerSubViews];
	
	self.employeeServicesViewController.view.frame = CGRectMake(self.employeeServicesViewController.view.frame.origin.x, self.employeeServicesViewController.view.frame.origin.y, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
	
	[self.contentContainerView addSubview:self.employeeServicesViewController.view];
	
	[self.headerUIViewController toggleTabActivation:Employees];
}

#pragma LeftPanelViewDelegate Methods
- (void)totalEmployeesButtonClicked {
	[self removeContentContainerSubViews];
	
	[self.contentContainerView addSubview:self.employeesViewController.view];
	
	[self.headerUIViewController toggleTabActivation:Employees];
}

- (void)companyButtonClicked {
	[self removeContentContainerSubViews];
	
	[self.contentContainerView addSubview:self.companyViewController.view];
	
	[self.headerUIViewController toggleTabActivation:Company];
}

#pragma EmployeesViewDelegate Methods
- (void)employeeVisaRenewalSelected {
	[self removeContentContainerSubViews];
	
	[self.contentContainerView addSubview:self.visaRenewalViewController.view];
	
	[self.headerUIViewController toggleTabActivation:Employees];
}

@end
