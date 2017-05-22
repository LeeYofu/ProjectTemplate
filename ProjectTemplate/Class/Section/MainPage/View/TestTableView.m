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
    
    // test
    // ?bCode=SH0001&dType=DAY&count=500&quota=MA
    NSDictionary *parameters = @{
                                 @"bCode" : @"SH0001",
                                 @"dType" : @"DAY",
                                 @"count" : @"500",
                                 @"quota" : @"MA"
                                 };
    [YFNetworkRequest GET:kGetDayKURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error = %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            [self showLoadingHUDWithText:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self hideHUD];
            });
        }
            break;
        case 1:
        {
            [self showTextHUDWithText:@"用户名不能为空"];
        }
            break;
        case 2:
        {
            [self showInfoHUDWithText:@"下载马上开始"];
        }
            break;
        case 3:
        {
            [self showSuccessHUDWithText:@"下载成功"];
        }
            break;
        case 4:
        {
            [self showErrorHUDWithText:@"网络错误，请检查网络"];
        }
            break;
            
        default:
            break;
    }
}

@end
