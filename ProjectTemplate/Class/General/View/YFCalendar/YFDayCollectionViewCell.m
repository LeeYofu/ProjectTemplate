//
//  YFDayCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFDayCollectionViewCell.h"

@interface YFDayCollectionViewCell()


@end

@implementation YFDayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    self.backgroundColor = kWhiteColor;
}

- (void)createSubviews {
    
    self.todayView = [[UIView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.todayView];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dayLabel];
}

@end
