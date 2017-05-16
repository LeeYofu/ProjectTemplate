//
//  BaseViewController.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

typedef NS_ENUM(NSInteger, EmptyDataType) {
    
    EmptyDataType_Loading,
    EmptyDataType_NoData,
    EmptyDataType_NetworkError
};

@interface BaseViewController : UIViewController

@property (nonatomic, strong) CustomNavigationBar *cNavigationBar;
@property (nonatomic, copy) NSString *cNavigationBarTitle;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) EmptyDataType emptyDataType;

- (void)config;
- (void)createSubviews;

@end
