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
        
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    
}
@end
