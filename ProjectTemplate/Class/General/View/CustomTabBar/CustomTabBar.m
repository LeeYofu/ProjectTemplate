//
//  CustomTabBar.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomTabBarButton.h"

@interface CustomTabBar()

@property (nonatomic, strong) NSMutableArray *buttonsArray; // 盛放自定义按钮的数组
@property (nonatomic, strong) UIButton *seletedButton; // 上一个被选中的按钮

@end

@implementation CustomTabBar

#pragma mark - 懒加载
- (NSMutableArray *)buttonsArray {
    
    if (_buttonsArray == nil) {
        
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}


#pragma mark - layoutSubviews 布局子控件
// 这个方法每设置一个属性就会走一次。
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat tabBarX = 0;
    CGFloat tabBarY = 0;
    CGFloat tabBarW = self.bounds.size.width / (self.itemsArray.count);
    CGFloat tabBarH = self.bounds.size.height;
    
    int i = 0;
    
    // 设置便利出来的 自定义按钮的frame
    for (UIView *tabBarButton in self.buttonsArray) {
        
        tabBarX = i * tabBarW;
        tabBarButton.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
        i ++;
    }
    
}

#pragma mark - 重写 items模型数组的set方法
- (void)setItemsArray:(NSArray *)itemsArray {
    
    _itemsArray = itemsArray;
    
    for (UITabBarItem *tabBarItem in itemsArray) {
        
        CustomTabBarButton *tabBarButton = [CustomTabBarButton buttonWithType:UIButtonTypeCustom];
        // 把便利出来的 UITabBarItem 对象赋值给 自定义按钮的 tabBarItem 属性
        tabBarButton.tabBarItem = tabBarItem;
        // 给自定义按钮设置tag值 0、1、2、3
        tabBarButton.tag = self.buttonsArray.count;
        [tabBarButton addTarget:self action:@selector(tabBarButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        /* 如果tag为0，说明是首页，那么要把这个按钮变为选中状态，默认是不选中的。 */
        if (tabBarButton.tag == 0) {
            
            [self tabBarButtonDidClicked:tabBarButton];
        }
        
        // 把自定义 按钮 加载的父视图上
        [self addSubview:tabBarButton];
        // 把自定义 按钮 添加到 自定义按钮数组
        [self.buttonsArray addObject:tabBarButton];
    }
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kSeparatorLineHeight)];
    lineView.backgroundColor = kCustomRGBColor(222, 222, 222, 1.0);
    [self addSubview:lineView];
}

#pragma mark - 自定义按钮被点击
- (void)tabBarButtonDidClicked:(CustomTabBarButton *)tabBarButton {
    
    self.seletedButton.selected = NO;
    tabBarButton.selected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickedAtIndex:)]) {
        
        [self.delegate tabBarDidClickedAtIndex:tabBarButton.tag];
    }
    
    // 动画
//    if ([self.seletedButton isEqual:tabBarButton]) {
//        return;
//    }
//    [UIView animateWithDuration:0.3f animations:^{
//        self.seletedButton.imageView.transform = CGAffineTransformIdentity;
//    }];
//    UIImageView *icon = tabBarButton.imageView;
//    {
//        UIViewAnimationOptions op = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut;
//        NSTimeInterval one = 0.18;
//        [UIView animateWithDuration:one delay:0 options:op animations:^{
//            icon.transform = CGAffineTransformMakeScale(1.3, 1.3);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:one delay:0 options:op animations:^{
//                icon.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:one delay:0 options:op animations:^{
//                    icon.transform = CGAffineTransformMakeScale(1.13, 1.13);
//                } completion:^(BOOL finished) {
//                    [UIView animateWithDuration:one delay:0 options:op animations:^{
//                        icon.transform = CGAffineTransformMakeScale(1.1, 1.1);
//                    } completion:NULL];
//                }];
//            }];
//        }];
//    }
    
    self.seletedButton = tabBarButton; // 记住上一个被选中的按钮
}

@end
