//
//  BaseViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface BaseViewController () <CustomNavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation BaseViewController

#pragma mark - 懒加载
- (CustomNavigationBar *)cNavigationBar {
    
    if (_cNavigationBar == nil) {
        
        _cNavigationBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.width, kNavigationBarHeight)];
        _cNavigationBar.delegate = self;
        _cNavigationBar.backButtonHidden = self.navigationController.viewControllers.count <= 1;
        [self.view addSubview:_cNavigationBar];
    }
    return _cNavigationBar;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 默认设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // 视图消失的时候，需要回收键盘
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self config];
    [self createSubviews];
}

#pragma mark - Public
- (void)config {
    
    self.view.backgroundColor = kWhiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    self.emptyDataType = EmptyDataType_Loading;
}

- (void)createSubviews {
    
    [self cNavigationBar]; // 加载自定义导航栏
}

#pragma mark - Private
- (void)navigationBarBackButtonDidClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCNavigationBarTitle:(NSString *)cNavigationBarTitle {
    
    _cNavigationBarTitle = cNavigationBarTitle;
    self.cNavigationBar.title = cNavigationBarTitle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
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
    
    [_tableView reloadEmptyDataSet];
}

@end
