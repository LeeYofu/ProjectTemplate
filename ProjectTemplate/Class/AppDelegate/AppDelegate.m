//
//  AppDelegate.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import <UMMobClick/MobClick.h>
//#import <JSPatchPlatform/JSPatch.h>
#import "AppDelegate+LaunchAD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - config
- (void)configWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    
    [self setUpTextFieldTextViewColor];
    [self setUpIQKeyboardManager];
    [self setUpMobClick];
//    [self setUpJSPatch];
//    [self setUpLaunchADView];
}

#pragma mark - 设置textField、textView的光标颜色
- (void)setUpTextFieldTextViewColor {
    
    [[UITextField appearance] setTintColor:kThemeColor];
    [[UITextView appearance] setTintColor:kThemeColor];
}

#pragma mark - IQKeyboardManager
- (void)setUpIQKeyboardManager {
    
    // IQKeyboardManager
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    [IQKeyboardManager sharedManager].shouldPlayInputClicks = YES;
}

#pragma mark - 友盟统计
- (void)setUpMobClick {
    
    [MobClick setAppVersion:XcodeAppVersion]; // 参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    UMConfigInstance.appKey = kMobClickKey;
    
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:kIsDebug];
}

#pragma mark - js热修复
//- (void)setUpJSPatch {
//    
//    [JSPatch startWithAppKey:kJSPatchKey];
//    [JSPatch sync];
//    
////    [JSPatch testScriptInBundle]; // 用于本地文件测试
//}

#pragma mark - 加载启动广告页面
- (void)setUpLaunchADView {
    
    [self setupLaunchAD];
}

#pragma mark - Launched --------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configWithApplication:application launchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CustomTabBarController *tabBarC = [CustomTabBarController new];
    self.window.rootViewController = tabBarC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
