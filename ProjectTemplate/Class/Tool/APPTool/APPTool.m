//
//  APPTool.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "APPTool.h"
#import <FCUUID.h>

@interface APPTool()

@end

@implementation APPTool

+ (NSString *)getDeviceUDID {
    
    NSString *result = [[FCUUID uuidForDevice] uppercaseString];
    return result;
}

+ (void)clearNSUserDefaults {
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
