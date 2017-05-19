//
//  AppDelegate+LaunchAD.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/23.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "AppDelegate+LaunchAD.h"
#import "XHLaunchAd.h"

//静态图
#define imageURL1 @"http://c.hiphotos.baidu.com/image/pic/item/4d086e061d950a7b78c4e5d703d162d9f2d3c934.jpg"
#define imageURL2 @"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg"
#define imageURL3 @"http://d.hiphotos.baidu.com/image/pic/item/64380cd7912397dd624a32175082b2b7d0a287f6.jpg"
#define imageURL4 @"http://d.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60071473204e150352ac75cb7f3.jpg"

//动态图
#define imageURL5 @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"
#define imageURL6 @"http://p1.bqimg.com/567571/4ce1a4c844b09201.gif"
#define imageURL7 @"http://p1.bqimg.com/567571/23a4bc7a285c1179.gif"

//视频链接
#define videoURL1 @"http://ohnzw6ag6.bkt.clouddn.com/video0.mp4"
#define videoURL2  @"http://120.25.226.186:32812/resources/videos/minion_01.mp4";
#define videoURL3 @"http://ohnzw6ag6.bkt.clouddn.com/video1.mp4"

@interface AppDelegate() <XHLaunchAdDelegate>

@end

@implementation AppDelegate (LaunchAD)

- (void)setupLaunchAD {
    
    [XHLaunchAd setWaitDataDuration:2];

    [YFNetworkRequest POST:@"https://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 使用默认配置初始化
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
        // 广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = imageURL6;
        // 广告点击打开链接
        imageAdconfiguration.openURLString = @"http://www.returnoc.com";
        imageAdconfiguration.duration = 3.0f;
        // 显示图片开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error = %@", error);
    }];
}

@end
