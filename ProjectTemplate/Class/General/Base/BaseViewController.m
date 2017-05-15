//
//  BaseViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface BaseViewController () <CustomNavigationBarDelegate>

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

@end
