//
//  HomePageViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/25.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "HomePageViewController.h"
#import "BannerView.h"
#import "YFCalendarView.h"

@interface HomePageViewController () <BannerViewDelegate>

@property (nonatomic, strong) YFCalendarView *calendarView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)createSubviews {
    
    [super createSubviews];
    
    [self testCalendarView];
    [self testNetworkRequest];
    [self testAnimationLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, 80, 80);
    button.backgroundColor = kYellowColor;
    [button addTarget:self action:@selector(testNetworkRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)testCalendarView {
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showButton.frame = CGRectMake(0, 20, 44, 44);
    showButton.backgroundColor = kGreenColor;
    [showButton addTarget:self action:@selector(showButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
    
    UIButton *hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideButton.frame = CGRectMake(self.view.width - 44, 20, 44, 44);
    hideButton.backgroundColor = kRedColor;
    [hideButton addTarget:self action:@selector(hideButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hideButton];
    
    
    self.calendarView = [YFCalendarView calendarViewWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, 200)];
    [self.view addSubview:self.calendarView];
}

#define kTimeLineUrl @"https://goldfishspot.qdztrk.com/goldfishfinance/quotation/quotationAllPrices?quotation=SH0001"
#define kDayKlineUrl @"https://goldfishspot.qdztrk.com/goldfishfinance/quotation/echartData?bCode=SH0001&dType=DAY&count=500&quota=MA"
#define kWeekKlineUrl @"https://goldfishspot.qdztrk.com/goldfishfinance/quotation/echartData?bCode=SH0001&dType=WEEK&count=150&quota=MA"
#define kMonthKlineUrl @"https://goldfishspot.qdztrk.com/goldfishfinance/quotation/echartData?bCode=SH0001&dType=MONTH&count=500&quota=MA"
#define kYearKLineUrl @"https://goldfishspot.qdztrk.com/goldfishfinance/quotation/echartData?bCode=SH0001&dType=YEAR&count=500&quota=MA"

#define kZhangShuaiURL1 @"http://123.56.4.22:7070/baseWeb/app/homemenu/get?ifAll=1"
#define kZhangShuaiURL2 @"http://123.56.4.22:7070/baseWeb/app/params/get"

- (void)testNetworkRequest {
    
//    [YFNetworkRequest GET:kTimeLineUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"success------1");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"failure------1");
//    }];
//    
//    [YFNetworkRequest GET:kDayKlineUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"success------2");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"failure------2");
//    }];
//    
//    [YFNetworkRequest GET:kWeekKlineUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"success------3");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"failure------3");
//    }];
//    
//    [YFNetworkRequest GET:kMonthKlineUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"success------4");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"failure------4");
//    }];
//    
//    [YFNetworkRequest GET:kYearKLineUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"success------5");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"failure------5");
//    }];
    
    NSLog(@"\n");
    
    [YFNetworkRequest POST:kZhangShuaiURL1 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success------6");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"failure------6");
    }];
    
    NSDictionary *parameters = @{ @"paramCode" : @"AppUpdateWarnInterval" };
    [YFNetworkRequest POST:kZhangShuaiURL2 parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"success------7");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"failure------7");
    }];
}

- (void)showButtonDidClicked {
    
    [self.calendarView show];

}

- (void)hideButtonDidClicked {
    
    [self.calendarView hide];

}

//- (void)bannerViewDidClickedAtIndex:(NSInteger)index {
//    
//    NSLog(@"index = %ld", index);
//}

- (void)testAnimationLabel {
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20, 450, 100, 40);
    [self.view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 方法一
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionFade;
        animation.duration = 0.75;
        [label.layer addAnimation:animation forKey:@"kCATransitionFade"];
        label.text = @"New";
    });
    
    [self performSelector:@selector(aaa) withObject:self afterDelay:2.0f];
    
    
//    // 方法二
//    [UIView transitionWithView:label
//                      duration:0.25f
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        
//                        label.text = @"Well done!";
//                        
//                    } completion:nil];

    
//  // 方法三
//    [UIView animateWithDuration:1.0
//                     animations:^{
//                         label.alpha = 0.0f;
//                         label.text = @"newText";
//                         label.alpha = 1.0f;
//                     }];
}

@end
