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
    self.cNavigationBar.title = @"首页";
    
    UIButton *userCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userCenterButton.frame = CGRectMake(10, 20, 44, 44);
    userCenterButton.backgroundColor = kBlueColor;
    [userCenterButton addTarget:self action:@selector(userCenterButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.cNavigationBar addSubview:userCenterButton];
}

//切换 到 左边 抽屉
- (void)userCenterButtonDidClicked {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
