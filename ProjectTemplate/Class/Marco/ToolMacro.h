//
//  ToolMarco.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

// 弱引用
#define kWeakSelf(ClassName) __weak typeof(ClassName *)weakSelf = self

// 屏幕宽度、高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height // 屏幕高度

// 沙盒路径
#define kPathOfAppHome     NSHomeDirectory()
#define kPathOfTemp        NSTemporaryDirectory()
#define kPathOfDocument    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 系统控件默认高度
#define kStatusBarHeight (20.0f)
#define kNavigationBarHeight (64.0f)
#define kTabBarHeight (49.0f)
#define kEnglishKeyboardHeight  (216.0f)
#define kChineseKeyboardHeight  (252.0f)

// 系统版本号
#define kDeviceSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

// 获取Xcode的版本号
#define kXcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 重写NSLog打印函数
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

// 单例宏
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_IMPLEMENTATION(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

// 一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter

// 由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
// 由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#endif /* ToolMarco_h */
