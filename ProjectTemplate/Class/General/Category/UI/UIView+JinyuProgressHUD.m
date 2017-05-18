//
//  UIView+JinyuProgressHUD.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "UIView+JinyuProgressHUD.h"
#import "JinyuProgressHUD.h"

#define kHUDMinWidth 100.0f
#define kShowDuration 1.5f

@implementation UIView (JinyuProgressHUD)

- (void)showHUDWithStatus:(JinyuProgressHUDStatus)status text:(NSString *)text {
    
    JinyuProgressHUD *hud = [JinyuProgressHUD sharedProgressHUD];
    
    [hud removeFromSuperview];
    
    [self addSubview:hud];
    
    hud.frame = self.bounds;
    
    hud.minSize = CGSizeMake(kHUDMinWidth, kHUDMinWidth);
    
    [hud showAnimated:YES];
    
    if (text.length) {
        
        hud.label.text = text;
    }

    switch (status) {
        case JinyuProgressHUDStatus_Text:
        {
            [self showTextHUDWithText:text];
        }
            break;
            
        case JinyuProgressHUDStatus_Watting:
        {
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
        case JinyuProgressHUDStatus_Success:
        {
            UIImage *image = [UIImage imageNamed:@"首页-点击"];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *customView = [[UIImageView alloc] initWithImage:image];
            hud.customView = customView;
        }
            break;
        case JinyuProgressHUDStatus_Error:
        {
            UIImage *image = [UIImage imageNamed:@"首页-点击"];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *customView = [[UIImageView alloc] initWithImage:image];
            hud.customView = customView;
        }
            break;
        case JinyuProgressHUDStatus_Info:
        {
            UIImage *image = [UIImage imageNamed:@"首页-点击"];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *customView = [[UIImageView alloc] initWithImage:image];
            hud.customView = customView;
        }
            break;
            
        default:
            break;
    }
    
    
    if (status != JinyuProgressHUDStatus_Watting) {
        
        [hud hideAnimated:YES afterDelay:kShowDuration];
    }
}

- (void)showTextHUDWithText:(NSString *)text {
    
    JinyuProgressHUD *hud = [JinyuProgressHUD sharedProgressHUD];
    
    [hud removeFromSuperview];
    
    [self addSubview:hud];
    
    hud.frame = self.bounds;
    
    [hud setMinSize:CGSizeZero];
    
    [hud showAnimated:YES];
    
    if (text.length) {
        
        hud.label.text = text;
    }
    
    hud.mode = MBProgressHUDModeText;
    
    [hud hideAnimated:YES afterDelay:kShowDuration];
}

- (void)showLoadingHUDWithText:(NSString *)text {
    
    
    [self showHUDWithStatus:JinyuProgressHUDStatus_Watting text:text];
}

- (void)showSuccessHUDWithText:(NSString *)text {
    
    [self showHUDWithStatus:JinyuProgressHUDStatus_Success text:text];
}

- (void)showErrorHUDWithText:(NSString *)text {
    
    [self showHUDWithStatus:JinyuProgressHUDStatus_Error text:text];
}

- (void)showInfoHUDWithText:(NSString *)text {
    
    [self showHUDWithStatus:JinyuProgressHUDStatus_Info text:text];
}

- (void)hideHUD {
    
    [[JinyuProgressHUD sharedProgressHUD] hideAnimated:YES];
    [[JinyuProgressHUD sharedProgressHUD] removeFromSuperview];
}

@end
