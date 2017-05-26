//
//  YFSegmentedControl.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/25.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFSegmentedControlDelegate <NSObject>

@optional

- (void)segmentedControlDidSelectedIndex:(NSInteger)selectedIndex;

@end

@interface YFSegmentedControl : UIScrollView

@property (nonatomic, weak) id<YFSegmentedControlDelegate> cDelegate;

+ (instancetype)segmentedControlWithFrame:(CGRect)frame titleArray:(NSArray <NSString *> *)titleArray titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor;
- (void)setContentOffsetX:(CGFloat)contentOffsetX;

@end
