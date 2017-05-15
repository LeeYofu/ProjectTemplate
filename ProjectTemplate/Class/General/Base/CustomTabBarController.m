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
    
    MainPageViewController *mainPageVC1 = [MainPageViewController new];
    [self addChildViewController:mainPageVC1 title:@"1" imageName:@"首页-未点击" selectedImageName:@"首页-点击"];
    
    MainPageViewController *mainPageVC2 = [MainPageViewController new];
    [self addChildViewController:mainPageVC2 title:@"2" imageName:@"首页-未点击" selectedImageName:@"首页-点击"];
    
    MainPageViewController *mainPageVC3 = [MainPageViewController new];
    [self addChildViewController:mainPageVC3 title:@"3" imageName:@"首页-未点击" selectedImageName:@"首页-点击"];
    
    MainPageViewController *mainPageVC4 = [MainPageViewController new];
    [self addChildViewController:mainPageVC4 title:@"4" imageName:@"首页-未点击" selectedImageName:@"首页-点击"];
    
    MainPageViewController *mainPageVC5 = [MainPageViewController new];
    [self addChildViewController:mainPageVC5 title:@"5" imageName:@"首页-未点击" selectedImageName:@"首页-点击"];

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
}

@end
