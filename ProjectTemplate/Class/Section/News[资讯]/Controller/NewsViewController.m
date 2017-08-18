//
//  NewsViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/8/15.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)createSubviews {
    
    [super createSubviews];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight - kTabBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        NSLog(@"1 - %f", self.tableView.contentSize.height);
//        
//        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + 500);
//        
//        NSLog(@"2 - %f", self.tableView.contentSize.height);
//        
//        [self.tableView reloadData];
//    });
//    [self.tableView reloadData];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.backgroundColor = kRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section + 1, indexPath.row + 1];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    headerView.backgroundColor = kClearColor;
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    testLabel.backgroundColor = kYellowColor;
    testLabel.text = [NSString stringWithFormat:@"%ld", section];
    [headerView addSubview:testLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

@end
