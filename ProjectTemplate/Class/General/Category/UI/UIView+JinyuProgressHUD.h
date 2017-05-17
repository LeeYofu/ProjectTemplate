//
//  UIView+JinyuProgressHUD.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JinyuProgressHUDStatus) {
    
    JinyuProgressHUDStatus_Text,
    JinyuProgressHUDStatus_Watting,
    JinyuProgressHUDStatus_Success,
    JinyuProgressHUDStatus_Error,
    JinyuProgressHUDStatus_Info,
};

@interface UIView (JinyuProgressHUD)

- (void)showHUDWithStatus:(JinyuProgressHUDStatus)status text:(NSString *)text;

- (void)showTextHUDWithText:(NSString *)text;
- (void)showLoadingHUDWithText:(NSString *)text;
- (void)showSuccessHUDWithText:(NSString *)text;
- (void)showErrorHUDWithText:(NSString *)text;
- (void)showInfoHUDWithText:(NSString *)text;

- (void)hideHUD;

@end
