//
//  TacticsViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/25.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "TacticsViewController.h"
#import "YFSegmentedControl.h"

@interface TacticsViewController () <YFSegmentedControlDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) YFSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TacticsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *titleArray = @[ @"热点", @"亚洲", @"美国", @"欧洲", @"贵金属", @"原油", @"热点", @"亚洲", @"美国", @"欧洲", @"贵金属", @"原油" ];
    
    self.segmentedControl = [YFSegmentedControl segmentedControlWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, 40) titleArray: titleArray titleColor:kCustomRGBColor(102, 102, 102, 1.0) titleSelectedColor:kThemeColor];
    self.segmentedControl.cDelegate = self;
    [self.view addSubview:self.segmentedControl];
    
    self.segmentedControl.backgroundColor = kWhiteColor;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.maxY, kScreenWidth, kScreenHeight - self.segmentedControl.maxY - kTabBarHeight)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(titleArray.count * kScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
//    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, self.scrollView.width, self.scrollView.height)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%d", i + 1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:80];
        [self.scrollView addSubview:label];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.segmentedControl setContentOffsetX:scrollView.contentOffset.x];
}

- (void)segmentedControlDidSelectedIndex:(NSInteger)selectedIndex {
    
    [self.scrollView setContentOffset:CGPointMake(selectedIndex * self.scrollView.width, 0) animated:NO];
}


@end
