//
//  CustomTabBarButton.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomTabBarButton.h"
#import "CustomTabBarBadgeView.h"

#define kImageRidio 0.70 // 按钮图片的高度比例

@interface CustomTabBarButton()

@property (nonatomic, strong) CustomTabBarBadgeView *badgeView; // 自定义badgeView（按钮，既能显示图片，又能显示文字）

@end

@implementation CustomTabBarButton

#pragma mark - 懒加载
- (CustomTabBarBadgeView *)badgeView {
    
    if (_badgeView == nil) {
        
        _badgeView = [CustomTabBarBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:_badgeView];
    }
    return _badgeView;
}

#pragma mark - 重写setHighlighted，取消高亮做的事情
// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 设置字体颜色
        [self setTitleColor:kColor0x999999 forState:UIControlStateNormal];
        [self setTitleColor:kThemeColor forState:UIControlStateSelected];
        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    [tabBarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [self setTitle:_tabBarItem.title forState:UIControlStateNormal];
    
    [self setImage:_tabBarItem.image forState:UIControlStateNormal];
    
    [self setImage:_tabBarItem.selectedImage forState:UIControlStateSelected];
    
    // 设置badgeValue
    self.badgeView.badgeValue = _tabBarItem.badgeValue;
}

// 修改按钮内部子控件的frame
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * kImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 5;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}


@end
