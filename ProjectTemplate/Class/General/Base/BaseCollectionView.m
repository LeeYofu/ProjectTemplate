//
//  BaseCollectionView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/24.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseCollectionView.h"

@interface BaseCollectionView()

@end

@implementation BaseCollectionView

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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    
}

- (void)createSubviews {
    
    
}

- (void)loadData {
    
    
}

@end
