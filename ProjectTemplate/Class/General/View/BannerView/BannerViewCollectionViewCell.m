//
//  BannerViewCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/26.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BannerViewCollectionViewCell.h"

@interface BannerViewCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BannerViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];

}

- (void)createSubviews {
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
}

- (void)setImageURLStr:(NSString *)imageURLStr {
    
    _imageURLStr = imageURLStr;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

@end
