//
//  YFNetworkRequest.h
//  NetworkRequestDemo
//
//  Created by 李友富 on 16/1/7.
//  Copyright © 2016年 李友富. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"

// base url
#define kBaseURLString kBaseURL

typedef NS_ENUM(NSUInteger, YFNetworkRequestCachePolicy) {
    
    YFNetworkRequestReturnCacheDataThenLoad = 0, // 有缓存就先返回缓存，同步请求数据
    YFNetworkRequestReloadIgnoringLocalCacheData, // 忽略缓存，重新请求
    YFNetworkRequestReturnCacheDataElseLoad, // 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    YFNetworkRequestReturnCacheDataDontLoad // 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

typedef void(^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

#define kNetworkStatusDidChangedNotification @"kNetworkStatusDidChangedNotification"

@interface YFNetworkRequest : AFHTTPSessionManager

#pragma mark GET
// GET请求（无缓存）
+ (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

// GET请求（有缓存）
+ (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark POST
// POST请求（无缓存）
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

// POST请求（有缓存）
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark PUT
// PUT请求（无缓存）
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

// PUT请求（有缓存）
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark DELETE
// DELETE请求（无缓存）
+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

// DELETE请求（有缓存）
+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark IMAGE/VIDEO
// 上传图片/视频
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters imageDatas:(NSArray *)imageDatas imageNames:(NSArray *)imageNames videoData:(NSData *)videoData success:(SuccessBlock)success failure:(FailureBlock)failure;

#pragma mark - 获取当前网络状态
+ (NetworkStatus)getCurrentNetworkStatus;

@end
