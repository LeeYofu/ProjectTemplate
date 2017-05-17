//
//  TestTableView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/16.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "TestTableView.h"

@implementation TestTableView

- (void)config {
    
    [super config];
    
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)loadData {
    
    [super loadData];
    
    // test
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        self.emptyDataType = EmptyDataType_NoData;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            self.emptyDataType = EmptyDataType_NetworkError;
        });
    });
    
//    [self showLoadingHUDWithText:@"8"];
//    [self showTextHUDWithText:@"我是提示文本"];
    [self showSuccessHUDWithText:@"success"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

@end
