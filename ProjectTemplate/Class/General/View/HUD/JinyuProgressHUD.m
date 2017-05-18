//
//  JinyuProgressHUD.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "JinyuProgressHUD.h"

@implementation JinyuProgressHUD

+ (instancetype)sharedProgressHUD {
    
    static JinyuProgressHUD *HUD = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        HUD = [JinyuProgressHUD new];
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        HUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
        HUD.contentColor = [UIColor whiteColor];
        HUD.removeFromSuperViewOnHide = YES;
        HUD.userInteractionEnabled = NO;
        HUD.animationType = MBProgressHUDAnimationFade;
    });
    
    return HUD;
}


@end
