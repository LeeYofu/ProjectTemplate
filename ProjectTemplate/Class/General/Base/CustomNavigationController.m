//
//  CustomNavigationController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation CustomNavigationController

//+ (void)initialize {
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//
//    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
//    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    normalDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [barButtonItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
//
//    NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
//    titleDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    titleDic[NSFontAttributeName] = [UIFont systemFontOfSize:18];
//    [[UINavigationBar appearance] setTitleTextAttributes:titleDic];
//
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
//
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//
//    [[UINavigationBar appearance] setBarTintColor:kBaseGreenColor];
//
//
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
#warning 开启策划手势 - 打开生命周期代理-注释掉自定义返回按钮
    [self customPopDistance];
    
    [self.navigationBar setHidden:YES];
}

#pragma mark - 返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >= 1) {
        
        // backbutton
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 16, 22);
        [backButton addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[UIImage imageNamed:@"back_wenzi_up"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back_wenzi_down"] forState:UIControlStateHighlighted];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        // 进入下级页面，需要隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回按钮点击事件
- (void)backButtonDidClicked {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - 返回距离
- (void)customPopDistance {
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    // handleNavigationTransition:
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    // 这里预防跟 tableview 侧滑编辑手势产生冲突
    CGPoint point = [gestureRecognizer translationInView:self.view];
    //    NSLog(@"%f, %f", point.x, point.y);
    if (point.x < 0) { // 说明是 往左滑
        
        return NO;
    }
    
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    return YES;
}

@end
