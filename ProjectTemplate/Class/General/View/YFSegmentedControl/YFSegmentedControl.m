//
//  YFSegmentedControl.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/25.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFSegmentedControl.h"

#define kFontSize kFont_16

#define kButtonLeftRightTotalPadding 25 // button左右总的padding
#define kDefaultLineViewWidth 12 // line view width

@interface YFSegmentedControl()

@property (nonatomic, strong) NSArray <NSString *> *titleArray;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) CGFloat lastContentOffsetX;

@property (nonatomic, strong) UIView *grandientLayerSuperView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation YFSegmentedControl

- (NSMutableArray *)buttonArray {
    
    if (_buttonArray == nil) {
        
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}

+ (instancetype)segmentedControlWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor {
    
    YFSegmentedControl *segmentedControl = [[YFSegmentedControl alloc] initWithFrame:frame];
    
    segmentedControl.titleArray = titleArray;
    segmentedControl.titleColor = titleColor;
    segmentedControl.titleSelectedColor = titleSelectedColor;
    
    [segmentedControl config];
    [segmentedControl createSubviews];
    
    return segmentedControl;
}

- (void)config {
    
    self.showsHorizontalScrollIndicator = NO;
}

- (void)createSubviews {
    
    [self createButton];
    
    self.contentSize = CGSizeMake(self.buttonArray.lastObject.maxX > self.width ? self.buttonArray.lastObject.maxX : self.width, 0);

    [self createLineView];
}

- (void)createButton {
    
    [self.buttonArray removeAllObjects];
    
    CGFloat sumWidth = 0;
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        
        CGFloat autoWidth = [self.titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : kFontSize } context:nil].size.width;
        
        autoWidth += kButtonLeftRightTotalPadding;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(sumWidth, 0, autoWidth, self.height);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = kFontSize;
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self.buttonArray addObject:button];
        
        if (i == 0) {
            
            self.selectedButton = button;
            self.selectedButton.selected = YES;
        }
        sumWidth += autoWidth;
    }
}

- (void)createLineView {
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = kThemeColor;
    [self addSubview:self.lineView];
    
    CGFloat lineViewHeight = 2;
    self.lineView.y = self.height - lineViewHeight - 5;
    self.lineView.height = lineViewHeight;
    self.lineView.width = kDefaultLineViewWidth;
    self.lineView.centerX = self.selectedButton.centerX;
    
    self.lineView.layer.cornerRadius = lineViewHeight * 0.5;
    self.lineView.layer.masksToBounds = YES;
    
//    [self openColorfulFunction];
}

- (void)openColorfulFunction {
    
    self.lineView.backgroundColor = kClearColor;
    
    self.grandientLayerSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.lineView.height)];
    [self.lineView addSubview:self.grandientLayerSuperView];
    
    // 初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.grandientLayerSuperView.bounds;
    // 设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(0, 0.5);
    self.gradientLayer.endPoint = CGPointMake(1, 0.5);
    // 设置颜色组
    self.gradientLayer.colors = @[
                                  (__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor orangeColor].CGColor,
                                  (__bridge id)[UIColor yellowColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor blueColor].CGColor,
                                  (__bridge id)[UIColor cyanColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor orangeColor].CGColor,
                                  (__bridge id)[UIColor yellowColor].CGColor,
                                  ];
    // 设置颜色分割点
    self.gradientLayer.locations = @[
                                     @0.1,
                                     @0.2,
                                     @0.3,
                                     @0.4,
                                     @0.5,
                                     @0.6,
                                     @0.7,
                                     @0.8,
                                     @0.9,
                                     @1
                                     ];
    // 添加
    [self.grandientLayerSuperView.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (void)buttonDidClicked:(UIButton *)button {
    
    NSInteger index = [self.buttonArray indexOfObject:button];
    
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
    
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(segmentedControlDidSelectedIndex:)]) {
        
        [self.cDelegate segmentedControlDidSelectedIndex:index];
    }
    
    
    [self resetContentOffset];
    [self resetLineViewFrameWithDuration:0.25];
    
    self.grandientLayerSuperView.frame = CGRectMake(-self.lineView.x, 0, self.contentSize.width, self.lineView.height);

}

- (void)resetContentOffset {
    
    CGFloat contentOffsetX = self.selectedButton.centerX - self.width * 0.5;
    if (contentOffsetX < 0) {
        
        contentOffsetX = 0;
    }
    if (contentOffsetX > self.contentSize.width - self.width) {
        
        contentOffsetX = self.contentSize.width - self.width;
    }
    [self setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

- (void)resetLineViewFrameWithDuration:(CGFloat)duration {
    
    [UIView animateWithDuration:duration animations:^{
        
        self.lineView.width = kDefaultLineViewWidth;
        self.lineView.centerX = self.selectedButton.centerX;
    }];
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX {

    if (contentOffsetX <= 0 || contentOffsetX >= self.width * (self.titleArray.count - 1)) {
        
        return;
    }
    
    // 普通的滑动效果
//    NSInteger newSelectedIndex = (NSInteger)((contentOffsetX + self.width * 0.5) / self.width);
//    
//    self.selectedButton.selected = NO;
//    self.selectedButton = self.buttonArray[newSelectedIndex];
//    self.selectedButton.selected = YES;
//    
//    [self resetContentOffset];
//    [self resetLineViewFrameWithDuration:0.25];

    
    
    // 选中线带有粘性的效果
    NSInteger selectedIndex = 0;
    NSInteger startContentOffsetX = 0;
    
    selectedIndex = [self.buttonArray indexOfObject:self.selectedButton];
    
    startContentOffsetX = self.width * selectedIndex;

    CGFloat contentOffsetPadding = contentOffsetX - startContentOffsetX;
    
    CGFloat scale = contentOffsetPadding / self.width;
    
    CGFloat absScale = ABS(scale);
    
    UIButton *selectedButton = self.buttonArray[selectedIndex];
    
    if (scale > 0) {
        
        NSInteger nextIndex = selectedIndex + 1;
        UIButton *nextButton = self.buttonArray[nextIndex];
        
        if (absScale < 0.5) {
            
            CGFloat rightPadding = nextButton.centerX + 0.5 * kDefaultLineViewWidth - (selectedButton.centerX + 0.5 * kDefaultLineViewWidth);
            self.lineView.width = kDefaultLineViewWidth + rightPadding * 2 * absScale;
            self.lineView.x = selectedButton.centerX - 0.5 * kDefaultLineViewWidth;
            
            self.selectedButton.selected = NO;
            self.selectedButton = selectedButton;
            self.selectedButton.selected = YES;
        } else {
            
            CGFloat leftPadding = nextButton.centerX - 0.5 * kDefaultLineViewWidth - (selectedButton.centerX - 0.5 * kDefaultLineViewWidth);
            self.lineView.x = selectedButton.centerX - 0.5 * kDefaultLineViewWidth + leftPadding * 2 * (absScale - 0.5);
            self.lineView.width = nextButton.centerX + 0.5 * kDefaultLineViewWidth - self.lineView.x;
            
            self.selectedButton.selected = NO;
            self.selectedButton = nextButton;
            self.selectedButton.selected = YES;
        }
    } else if (scale < 0) {
        
        NSInteger preIndex = selectedIndex - 1;
        UIButton *preButton = self.buttonArray[preIndex];
        
        if (absScale < 0.5) {
            
            CGFloat leftPadding = selectedButton.centerX - 0.5 * kDefaultLineViewWidth - (preButton.centerX - 0.5 * kDefaultLineViewWidth);
            self.lineView.x = selectedButton.centerX - 0.5 * kDefaultLineViewWidth - leftPadding * 2 * absScale;
            self.lineView.width = selectedButton.centerX + 0.5 * kDefaultLineViewWidth - self.lineView.x;
            
            self.selectedButton.selected = NO;
            self.selectedButton = selectedButton;
            self.selectedButton.selected = YES;
        } else {
            
            CGFloat rightPadding = selectedButton.centerX + 0.5 * kDefaultLineViewWidth - (preButton.centerX + 0.5 * kDefaultLineViewWidth);
            self.lineView.width = rightPadding + kDefaultLineViewWidth - rightPadding * 2 * (absScale - 0.5);
            self.lineView.x = preButton.centerX - 0.5 * kDefaultLineViewWidth;
            
            self.selectedButton.selected = NO;
            self.selectedButton = preButton;
            self.selectedButton.selected = YES;
        }
    }

    
    self.grandientLayerSuperView.frame = CGRectMake(-self.lineView.x, 0, self.contentSize.width, self.lineView.height);

    self.lastContentOffsetX = contentOffsetX;
    
    [self resetContentOffset];
}









//    if (scale > 0) {
//
//        NSInteger nextIndex = selectedIndex + 1;
//        UIButton *nextButton = self.buttonArray[nextIndex];
//
//        if (absScale < 0.5) {
//
//            CGFloat rightPadding = nextButton.width;
//            self.lineView.width = selectedButton.width - kButtonLeftRightTotalPadding + rightPadding * 2 * absScale;
//            self.lineView.x = selectedButton.x + 0.5 * kButtonLeftRightTotalPadding;
//        } else {
//
//            CGFloat leftPadding = selectedButton.width;
//            self.lineView.x = selectedButton.x + 0.5 * kButtonLeftRightTotalPadding + leftPadding * 2 * (absScale - 0.5);
//            self.lineView.width = nextButton.maxX - 0.5 * kButtonLeftRightTotalPadding - self.lineView.x;
//
//            self.selectedButton.selected = NO;
//            self.selectedButton = nextButton;
//            self.selectedButton.selected = YES;
//        }
//    } else if (scale < 0) {
//
//        NSInteger preIndex = selectedIndex - 1;
//        UIButton *preButton = self.buttonArray[preIndex];
//
//        if (absScale < 0.5) {
//
//            CGFloat leftPadding = preButton.width;
//            self.lineView.x = selectedButton.x + 0.5 * kButtonLeftRightTotalPadding - leftPadding * 2 * absScale;
//            self.lineView.width = selectedButton.maxX - 0.5 * kButtonLeftRightTotalPadding - self.lineView.x;
//        } else {
//
//            CGFloat rightPadding = selectedButton.width;
//            self.lineView.width = selectedButton.width + preButton.width - kButtonLeftRightTotalPadding - rightPadding * 2 * (absScale - 0.5);
//            self.lineView.x = preButton.x + 0.5 * kButtonLeftRightTotalPadding;
//
//            self.selectedButton.selected = NO;
//            self.selectedButton = preButton;
//            self.selectedButton.selected = YES;
//        }
//    }

@end
