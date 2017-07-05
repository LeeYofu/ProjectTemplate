//
//  YFMarket.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/7/5.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFMarketMacro.h"
@class YFMarketView;

@protocol YFMarketViewDataSource <NSObject>

@required
- (NSArray *)YFMarketView:(YFMarketView *)marketView marketDataOfType:(YFMarketLineDetailType)type;
- (void)YFMarketView:(YFMarketView *)marketView didSelectedLineDetailType:(YFMarketLineDetailType)type;

@optional

@end

@interface YFMarketView : UIView

+ (instancetype)marketWithFrame:(CGRect)frame dataSource:(id <YFMarketViewDataSource>)dataSource;

@end
