//
//  BaseCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/24.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
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
