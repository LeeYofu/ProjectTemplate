//
//  AppDelegate+AppService.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/6/5.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

// 配置下面所有的方法
- (void)config;

- (void)configNotification;
- (void)configTextFieldTextViewTintColor;
- (void)configIQKeyboardManager;
- (void)configMobClick;
- (void)configLaunchAdvertisementView;
- (void)configAvoidCrash;
- (void)configStatusBarHiddenWhenLaunch;

@end
