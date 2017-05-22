//
//  UIImage+Category.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/3/2.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

+ (UIImage *)imageWithColor:(UIColor *)color;

// 获取图像某一像素点的颜色
- (UIColor *)colorAtPixel:(CGPoint)point;



@end
