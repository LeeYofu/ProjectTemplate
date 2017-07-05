//
//  YFMarket.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/7/5.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFMarketView.h"

@interface YFMarketView()

@property (nonatomic, weak) id <YFMarketViewDataSource> dataSource;

@end

@implementation YFMarketView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id <YFMarketViewDataSource>)dataSource {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = dataSource;
        
        [self config];
        [self createSubviews];
        
    }
    return self;
}

+ (instancetype)marketWithFrame:(CGRect)frame dataSource:(id)dataSource {
    
    return [[self alloc] initWithFrame:frame dataSource:dataSource];
}

- (void)config {
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    
}

- (void)createSubviews {
    
    
}

@end
