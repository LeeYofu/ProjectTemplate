//
//  AppDelegate+AppService.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/6/5.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UMMobClick/MobClick.h>
#import <AvoidCrash.h>
#import "XHLaunchAd.h"
#import "CoreNewFeatureVC.h"
#import "CustomTabBarController.h"

@implementation AppDelegate (AppService)

#pragma mark - 配置所有
- (void)config {
    
    [self configNotification];
    [self configTextFieldTextViewTintColor];
    [self configIQKeyboardManager];
    [self configMobClick];
    //    [self configLaunchAdvertisementView];
    [self configAvoidCrash];
    [self configStatusBarHiddenWhenLaunch];
    [self configNewFeatureVC];
}

#pragma mark - 推送通知
- (void)configNotification {
    
    
}

#pragma mark - textField、textView光标颜色
- (void)configTextFieldTextViewTintColor {
    
    [[UITextField appearance] setTintColor:kThemeColor];
    [[UITextView appearance] setTintColor:kThemeColor];
}

#pragma mark - IQKeyboardManager
- (void)configIQKeyboardManager {
    
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    [IQKeyboardManager sharedManager].shouldPlayInputClicks = YES;
}

#pragma mark - 友盟统计
- (void)configMobClick {
    
    [MobClick setAppVersion:XcodeAppVersion]; // 参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    UMConfigInstance.appKey = kMobClickKey;
    
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:kIsDebug];
}

#pragma mark - 启动广告
- (void)configLaunchAdvertisementView {
    
    [XHLaunchAd setWaitDataDuration:2];
    
    // 使用默认配置初始化
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    // 广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"http://p1.bqimg.com/567571/4ce1a4c844b09201.gif";
    // 广告点击打开链接
    imageAdconfiguration.openURLString = @"http://www.returnoc.com";
    imageAdconfiguration.duration = 3.0f;
    // 显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

#pragma mark - 避免崩溃
- (void)configAvoidCrash {
    
    if (kIsDebug == NO) {
        
        [AvoidCrash becomeEffective];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    }
}

#pragma mark - 程序启动隐藏状态栏
- (void)configStatusBarHiddenWhenLaunch {
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}

#pragma mark - 新特性引导图
- (void)configNewFeatureVC {
    
    // 新特性图片
    // 判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [CoreNewFeatureVC canShowNewFeature];
    
    // 测试代码，正式版本应该删除
//    canShow = kIsDebug;
    
    if(canShow) {
        
        NSMutableArray *modelArray = [NSMutableArray new];
        NSString *imageName = @"";
        for (int i = 0; i < 4; i ++) {
            
            if (kIsIphone4) {
                
                imageName = [NSString stringWithFormat:@"4_%02d", i + 1];
            } else if (kIsIphone5) {
                
                imageName = [NSString stringWithFormat:@"5_%02d", i + 1];
            } else if (kIsIphone6) {
                
                imageName = [NSString stringWithFormat:@"6_%02d", i + 1];
            } else if (kIsIphone6P) {
                
                imageName = [NSString stringWithFormat:@"7_%02d", i + 1];
            } else {
                
                
            }
            UIImage *image = [UIImage imageNamed:imageName];
            NewFeatureModel *model = [NewFeatureModel model:image];
            
            [modelArray addObject:model];
        }
        
        self.window.rootViewController = [CoreNewFeatureVC newFeatureVCWithModels:modelArray enterBlock:^{
            
            [self enterMainVC];
        }];
    } else {
        
        [self enterMainVC];
    }
}

- (void)enterMainVC {
    
    self.window.rootViewController = [CustomTabBarController new];
}

#pragma mark - Other
- (void)dealwithCrashMessage:(NSNotification *)note {
    
    // 注意:所有的信息都在userInfo中
    // 可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}

#pragma mark - 生命周期
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
