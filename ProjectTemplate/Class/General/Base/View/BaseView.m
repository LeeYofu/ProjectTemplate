//
//  BaseView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = kWhiteColor;
        [self config];
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kWhiteColor;
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    
}

- (void)createSubviews {
    
    
}

@end
