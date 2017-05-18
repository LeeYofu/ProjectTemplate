//
//  BaseTableView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView() <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation BaseTableView

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

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    self.delegate = self;
    self.dataSource = self;
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
}

- (void)createSubviews {
    
    self.tableFooterView = [UIView new];
}

- (void)loadData {
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark emptyData 代理方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    switch (self.emptyDataType) {
        case EmptyDataType_Loading:
        {
            return [UIImage imageNamed:@"首页-点击"];
        }
            break;
        case EmptyDataType_NoData:
        {
            return [UIImage imageNamed:@"项目-点击"];
        }
            break;
        case EmptyDataType_NetworkError:
        {
            return [UIImage imageNamed:@"我的-点击"];
        }
            break;
            
        default:
        {
            return nil;
        }
            break;
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text;
    
    switch (self.emptyDataType) {
        case EmptyDataType_Loading:
        {
            text = @"加载中…";
        }
            break;
        case EmptyDataType_NoData:
        {
            text = @"没有数据";
        }
            break;
        case EmptyDataType_NetworkError:
        {
            text = @"网络不给力，请检查网络";
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *attribute = @{ NSFontAttributeName: kFont_15, NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
//
//    NSString *text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    NSDictionary *attribute = @{ NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName : [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
//    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
//}
//
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    return [[NSAttributedString alloc] initWithString:@"点我" attributes:attribute];
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com"]];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//
//        [[UIApplication sharedApplication] openURL:url];
//    }
//}
//
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哈哈" message:@"最近咋样" delegate:nil cancelButtonTitle:@"别点我" otherButtonTitles:@"点我干啥", nil];
    [alert show];
    
}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
//
//    return 30;
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//
//    return -10;
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    
    return kWhiteColor;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    
    return self.emptyDataType == EmptyDataType_Loading;
}

#pragma mark - setter
- (void)setEmptyDataType:(EmptyDataType)emptyDataType {
    
    _emptyDataType = emptyDataType;
    
    [self reloadEmptyDataSet];
}

@end
