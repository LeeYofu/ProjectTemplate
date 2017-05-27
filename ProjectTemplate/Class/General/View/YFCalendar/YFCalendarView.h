//
//  YFCalendarView.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCalendarView : UIView

#warning 去掉初始化，直接用show方法封装
+ (instancetype)calendarViewWithFrame:(CGRect)frame;
- (void)show;
- (void)hide;

@end
