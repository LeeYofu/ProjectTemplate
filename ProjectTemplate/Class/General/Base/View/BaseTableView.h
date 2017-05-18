//
//  BaseTableView.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView

@property (nonatomic, assign) EmptyDataType emptyDataType;

- (void)config;
- (void)createSubviews;
- (void)loadData;

@end
