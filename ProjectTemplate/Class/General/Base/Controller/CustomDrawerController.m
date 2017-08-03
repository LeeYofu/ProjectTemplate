//
//  CustomDrawerController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/18.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomDrawerController.h"
#import <MMDrawerController.h>
#import "MMExampleDrawerVisualStateManager.h"
#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "UserCenterViewController.h"

@interface CustomDrawerController ()

@end

@implementation CustomDrawerController

+ (instancetype)drawerController {
    
    [MMExampleDrawerVisualStateManager sharedManager].leftDrawerAnimationType = MMDrawerAnimationTypeSlide;
    
    // left
    UserCenterViewController *userCenterVC = [UserCenterViewController new];
    CustomNavigationController *userCenterNaviC = [[CustomNavigationController alloc] initWithRootViewController:userCenterVC];
    // center
    CustomTabBarController *tabBarC = [CustomTabBarController new];

    // drawerController
    CustomDrawerController *drawerController = [[CustomDrawerController alloc] initWithCenterViewController:tabBarC leftDrawerViewController:userCenterNaviC];
    
    drawerController.showsShadow = NO;
    
    drawerController.maximumLeftDrawerWidth = kScreenWidth - 80;
    
    drawerController.animationVelocity = 1200.0f;
    
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    // 左右 控制器打开的效果 这里设置了 视觉差 效果
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block) {
            
            block(drawerController, drawerSide, percentVisible);
        }
        
        [drawerController.centerViewController.view setAlpha:(1 - percentVisible * 0.35)];
    }];
    
    return drawerController;
}

@end
