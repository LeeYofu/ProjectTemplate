//
//  MainPageViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/24.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "MainPageViewController.h"
#import "TestTableView.h"

@interface MainPageViewController ()


@end

@implementation MainPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self test];
}

- (void)config {
    
    [super config];
}

- (void)createSubviews {
    
    [super createSubviews];

    self.cNavigationBarTitle = @"李友富";
    
    TestTableView *tableView = [[TestTableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    [tableView loadData];
    
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

- (void)test {
    
    
}

- (void)userCenterButtonDidClicked {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)pushButtonDidClicked {
    
    BaseViewController *testVC = [BaseViewController new];
    [self.navigationController pushViewController:testVC animated:YES];
    
//    CustomNavigationController *naviC = [[CustomNavigationController alloc] initWithRootViewController:testVC];
//    [self presentViewController:naviC animated:YES completion:^{
//        
//    }];
}

@end
