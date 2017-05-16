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

- (void)config {
    
    [super config];
    
    // test
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.emptyDataType = EmptyDataType_NoData;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.emptyDataType = EmptyDataType_NetworkError;
        });
    });
}

- (void)createSubviews {
    
    [super createSubviews];

    self.cNavigationBarTitle = @"李友富";
    
    self.tableView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}


- (void)userCenterButtonDidClicked {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)pushButtonDidClicked {
    
    MainPageViewController *testVC = [MainPageViewController new];
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
