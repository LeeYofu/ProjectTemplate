//
//  BannerView.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/26.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerViewDelegate <NSObject>

@optional
- (void)bannerViewDidClickedAtIndex:(NSInteger)index;

@end

@interface BannerView : UIView

@property (nonatomic, strong) NSArray <NSString *> *imageURLStrArray;

+ (instancetype)bannerViewWithFrame:(CGRect)frame delegate:(id <BannerViewDelegate>)delegate autoScrollTimeInterval:(CGFloat)autoScrollTimeInterval;

@end
