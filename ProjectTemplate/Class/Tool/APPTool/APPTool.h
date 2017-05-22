//
//  APPTool.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPTool : NSObject

// 获取设备UDID
+ (NSString *)getDeviceUDID;

// 清空NSUserDefaults存储的所有内容
+ (void)clearNSUserDefaults;

// 获取苹果手机安装的所有APP
+ (NSArray *)getAllInstalledAPPFromIphoneDevice;

@end
