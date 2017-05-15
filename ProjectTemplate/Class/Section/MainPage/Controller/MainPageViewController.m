//
//  MainPageViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/24.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()


@end

@implementation MainPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)createSubviews {
    
    [super createSubviews];

    self.cNavigationBarTitle = @"李友富";
    
    UIButton *userCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userCenterButton.frame = CGRectMake(10, 20, 44, 44);
    userCenterButton.backgroundColor = kBlueColor;
    [userCenterButton addTarget:self action:@selector(userCenterButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.cNavigationBar addSubview:userCenterButton];
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(10, 120, 44, 44);
    pushButton.backgroundColor = kBlueColor;
    [pushButton addTarget:self action:@selector(pushButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)userCenterButtonDidClicked {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)pushButtonDidClicked {
    
    MainPageViewController *testVC = [MainPageViewController new];
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
