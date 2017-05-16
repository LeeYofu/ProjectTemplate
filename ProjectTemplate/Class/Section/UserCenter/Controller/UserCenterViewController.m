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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

@end
