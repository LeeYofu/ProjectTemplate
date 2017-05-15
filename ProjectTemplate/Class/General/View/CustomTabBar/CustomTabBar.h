//
//  CustomTabBar.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseView.h"

@protocol CustomTabBarDelegate <NSObject>

@optional

- (void)tabBarDidClickedAtIndex:(NSInteger)index;

@end

@interface CustomTabBar : BaseView

@property (nonatomic, strong) NSArray *itemsArray; // 盛放item模型的数组
@property (nonatomic, weak) id<CustomTabBarDelegate> delegate; // 代理

@end
