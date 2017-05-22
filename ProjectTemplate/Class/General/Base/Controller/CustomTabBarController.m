//
//  CustomTabBarController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "CustomTabBar.h"
#import "MainPageViewController.h"

@interface CustomTabBarController () <CustomTabBarDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *viewControllerNameArray;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) NSArray *selectedImageNameArray;

@property (nonatomic, strong) NSMutableArray *itemsArray; // 盛放items模型的数组

@end

@implementation CustomTabBarController

- (NSMutableArray *)itemsArray {
    
    if (_itemsArray == nil) {
        
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

+ (void)initialize {
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSFontAttributeName] = kFont_11;
    normalDic[NSForegroundColorAttributeName] = kCustomRGBColor(128, 128, 128, 1.0f);
    [tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    NSMutableDictionary *selecterDic = [NSMutableDictionary dictionary];
    selecterDic[NSFontAttributeName] = kFont_11;
    selecterDic[NSForegroundColorAttributeName] = kThemeColor;
    [tabBarItem setTitleTextAttributes:selecterDic forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self config];
    
    [self createChildViewController];
    
    [self createCustomTabbar];

    
}

- (void)config {
    
    self.titleArray = @[ @"首页", @"行情", @"资讯", @"直播" ];
    self.viewControllerNameArray = @[ @"MainPageViewController", @"BaseViewController", @"BaseViewController", @"BaseViewController" ];
    self.imageNameArray = @[ @"首页-未点击", @"首页-未点击", @"首页-未点击", @"首页-未点击" ];
    self.selectedImageNameArray = @[ @"首页-点击", @"首页-点击", @"首页-点击", @"首页-点击" ];
}

- (void)createChildViewController {
    
    for (int i = 0; i < self.viewControllerNameArray.count; i ++) {
        
        BaseViewController *VC = [NSClassFromString(self.viewControllerNameArray[i]) new];
        [self addChildViewController:VC title:self.titleArray[i] imageName:self.imageNameArray[i] selectedImageName:self.selectedImageNameArray[i]];
    }
}

- (void)createCustomTabbar {
    
    // 添加自定义tabBar
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = kWhiteColor;
    tabBar.delegate = self;
    // 盛放 item模型的数组赋值
    tabBar.itemsArray = self.itemsArray;
    [self.tabBar addSubview:tabBar];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CustomNavigationController *navigationC = [[CustomNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:navigationC];
    
    // 保存tabBarItem模型到数组
    [self.itemsArray addObject:childController.tabBarItem];
}

- (void)tabBarDidClickedAtIndex:(NSInteger)index {
    
    self.selectedIndex = index;
    
    if (self.selectedIndex == 0) {  // 只有首页才有抽屉效果
        
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    } else {
        
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
        self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    }
}



@end
