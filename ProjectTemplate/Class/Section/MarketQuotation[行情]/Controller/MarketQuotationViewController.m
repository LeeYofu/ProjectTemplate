//
//  MarketQuotationViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/25.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "MarketQuotationViewController.h"
#import "YFMarketView.h"

@interface MarketQuotationViewController () <YFMarketViewDataSource>

@property (nonatomic, strong) YFMarketView *marketView;

@end

@implementation MarketQuotationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.marketView = [YFMarketView marketWithFrame:CGRectMake(0, 100, kScreenWidth, 400) dataSource:self];
    [self.view addSubview:self.marketView];
    
    
}

- (NSArray *)YFMarketView:(YFMarketView *)marketView marketDataOfType:(YFMarketLineDetailType)type {
    
    return nil;
}

- (void)YFMarketView:(YFMarketView *)marketView didSelectedLineDetailType:(YFMarketLineDetailType)type {
    
    
}

@end
