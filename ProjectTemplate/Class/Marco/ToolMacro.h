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
#define kPathOfAppHome    NSHomeDirectory()
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

#endif /* ToolMarco_h */
