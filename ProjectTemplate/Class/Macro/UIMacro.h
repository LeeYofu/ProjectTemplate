//
//  UIMarco.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

#pragma mark - 颜色
/* 颜色 */
#define kThemeColor kCustomRGBColor(71, 145, 244, 1.0) // 主题色
#define kLineViewColor kColor0xded6de // 分割线颜色
#define kBackgroundColor kColor0xeff0f4 // 背景色

// 自定义颜色
#define kColor0x333333 kCustom0xColor(0x333333, 1.0f)
#define kColor0x999999 kCustom0xColor(0x999999, 1.0f)
#define kColor0xded6de kCustom0xColor(0xded6de, 1.0f)
#define kColor0xeff0f4 kCustom0xColor(0xeff0f4, 1.0f)
#define kColor0x6b6e86 kCustom0xColor(0x6b6e86, 1.0f)

// 常用颜色
#define kWhiteColor     [UIColor whiteColor]
#define kBlackColor     [UIColor blackColor]
#define kBlueColor      [UIColor blueColor]
#define kBrownColor     [UIColor brownColor]
#define kClearColor     [UIColor clearColor]
#define kDarkGrayColor  [UIColor darkGrayColor]
#define kYellowColor    [UIColor yellowColor]
#define kRedColor       [UIColor redColor]
#define kOrangeColor    [UIColor orangeColor]
#define kPurpleColor    [UIColor purpleColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGreenColor     [UIColor greenColor]
#define kGrayColor      [UIColor grayColor]
#define kMagentaColor   [UIColor magentaColor]

// 随机色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

#define kCustomRGBColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)] // 自定义颜色rgb颜色
#define kCustom0xColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue] // 自定义16进制颜色


#pragma mark - 字体
/* 字体 */
#define kFont_20 [UIFont systemFontOfSize:20]
#define kFont_19 [UIFont systemFontOfSize:19]
#define kFont_18 [UIFont systemFontOfSize:18]
#define kFont_17 [UIFont systemFontOfSize:17]
#define kFont_16 [UIFont systemFontOfSize:16]
#define kFont_15 [UIFont systemFontOfSize:15]
#define kFont_14 [UIFont systemFontOfSize:14]
#define kFont_13 [UIFont systemFontOfSize:13]
#define kFont_12 [UIFont systemFontOfSize:12]
#define kFont_11 [UIFont systemFontOfSize:11]
#define kFont_10 [UIFont systemFontOfSize:10]
#define kFont_9 [UIFont systemFontOfSize:9]
#define kFont_8 [UIFont systemFontOfSize:8]

#define kFontL(size) [UIFont systemFontOfSize:size weight:UIFontWeightLight]
#define kFontR(size) [UIFont systemFontOfSize:size weight:UIFontWeightRegular]
#define kFontB(size) [UIFont systemFontOfSize:size weight:UIFontWeightBold]
#define kFontT(size) [UIFont systemFontOfSize:size weight:UIFontWeightThin]
#define kFont(size) FontL(s)


#pragma mark - Frame
#define kSeparatorLineHeight (1 / [UIScreen mainScreen].scale)

#define kSetStatusBarStyle(statusBarStyle, isAnimated) [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:isAnimated]

#endif /* UIMarco_h */
