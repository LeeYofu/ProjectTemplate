//
//  CustomNavigationBar.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/15.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kThemeColor;
        
        [self createSubviews];
    }
    
    return self;
}

- (void)createSubviews {
    
    self.titleLabel = [UILabel new];
    CGFloat left_rightPadding = 50;
    CGFloat topPadding = 20;
    self.titleLabel.frame = CGRectMake(left_rightPadding, topPadding, self.width - 2 * left_rightPadding, kNavigationBarHeight - topPadding);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kWhiteColor;
    self.titleLabel.font = kFont_18;
    [self addSubview:self.titleLabel];
    
    // backbutton
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(5, topPadding, 16, kNavigationBarHeight - topPadding);
    [self.backButton addTarget:self action:@selector(backButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage imageNamed:@"back_wenzi_up"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"back_wenzi_down"] forState:UIControlStateHighlighted];
    self.backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backButton.hidden = YES;
    [self addSubview:self.backButton];
}

- (void)backButtonDidClicked {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarBackButtonDidClicked)]) {
        
        [self.delegate navigationBarBackButtonDidClicked];
    }
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setBackButtonHidden:(BOOL)backButtonHidden {
    
    _backButtonHidden = backButtonHidden;
    self.backButton.hidden = backButtonHidden;
}

@end
