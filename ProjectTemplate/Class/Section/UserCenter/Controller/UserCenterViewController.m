//
//  UserCenterViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/15.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)config {
    
    [super config];
    
    self.view.backgroundColor = kWhiteColor;
    self.cNavigationBarTitle = @"UserCenter";
    
}

- (void)createSubviews {
    
    [super createSubviews];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, self.cNavigationBar.width, kScreenHeight - kNavigationBarHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLog(@"%@", NSStringFromCGRect(tableView.frame));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

@end
