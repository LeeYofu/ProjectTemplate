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

+ (NSArray *)getAllInstalledAPPFromIphoneDevice {
    
    Class c =NSClassFromString(@"LSApplicationWorkspace");
    id s = [(id)c performSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSArray *array = [s performSelector:NSSelectorFromString(@"allInstalledApplications")];
//    for (id item in array) {
//        
//        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"applicationIdentifier")]);
//        //        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleIdentifier")]);
//        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"bundleVersion")]);
//        NSLog(@"%@",[item performSelector:NSSelectorFromString(@"shortVersionString")]);
//    }
    return array;
}

@end
