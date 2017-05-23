//
//  YFNetworkRequest.m
//  NetworkRequestDemo
//
//  Created by 李友富 on 16/1/7.
//  Copyright © 2016年 李友富. All rights reserved.
//

#import "YFNetworkRequest.h"
#import <YYCache/YYCache.h>
#import "NSJSONSerialization+YFJson.h"

typedef NS_ENUM(NSUInteger, YFNetworkRequestType) {
    
    YFNetworkRequestTypeGET = 0,
    YFNetworkRequestTypePOST,
    YFNetworkRequestTypePUT,
    YFNetworkRequestTypeDELETE
};

static NSString * const YFNetworkRequestCache = @"YFNetworkRequestCache";

@interface YFNetworkRequest()

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation YFNetworkRequest

#pragma mark - public
#pragma mark GET
+ (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeGET URLString:URLString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:success failure:failure];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeGET URLString:URLString parameters:parameters cachePolicy:requestCachePolicy success:success failure:failure];
}

#pragma mark POST
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePOST URLString:URLString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePOST URLString:URLString parameters:parameters cachePolicy:requestCachePolicy success:success failure:failure];
}

#pragma mark PUT
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePUT URLString:URLString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:success failure:failure];
}

+ (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePUT URLString:URLString parameters:parameters cachePolicy:requestCachePolicy success:success failure:failure];
}

#pragma mark DELETE
+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeDELETE URLString:URLString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:success failure:failure];
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeDELETE URLString:URLString parameters:parameters cachePolicy:requestCachePolicy success:success failure:failure];
}

// 上传视频/图片
+ (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters imageDatas:(NSArray *)imageDatas imageNames:(NSArray *)imageNames videoData:(NSData *)videoData success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    return [[YFNetworkRequest sharedInstance] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageDatas.count; i++) {
            
            [formData appendPartWithFileData:[imageDatas objectAtIndex:i] name:[imageNames objectAtIndex:i] fileName:[NSString stringWithFormat:@"%@.jpg",[imageNames objectAtIndex:i]] mimeType:@"image/jpeg"];
        }
        
        if (videoData) {
            
            [formData appendPartWithFileData:videoData name:@"video" fileName:[NSString stringWithFormat:@"%@.mp4",@"video"] mimeType:@"video/mp4"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(task, error);
        }
    }];
}

#pragma mark - private
+ (NSURLSessionDataTask *)requestMethod:(YFNetworkRequestType)type URLString:(NSString *)URLString parameters:(id)parameters cachePolicy:(YFNetworkRequestCachePolicy)cachePolicy success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    NSURLSessionDataTask *task;
    
    NSString *cacheKey = URLString;
    
    if (parameters) {
        
        if (! [NSJSONSerialization isValidJSONObject:parameters]) return task;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URLString stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:YFNetworkRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    id object = [cache objectForKey:cacheKey];
    
    switch (cachePolicy) {
            
        case YFNetworkRequestReturnCacheDataThenLoad : { // 先返回缓存，同时请求
            if (object) {
                
                success(nil,object);
            }
            break;
        }
        case YFNetworkRequestReloadIgnoringLocalCacheData : { // 忽略本地缓存直接请求
            
            // 不做处理，直接请求
            break;
        }
        case YFNetworkRequestReturnCacheDataElseLoad : { // 有缓存就返回缓存，没有就请求
            
            if (object) { // 有缓存
                
                success(nil,object);
                return task;
            }
            break;
        }
        case YFNetworkRequestReturnCacheDataDontLoad : { // 有缓存就返回缓存,从不请求（用于没有网络）
            
            if (object) { // 有缓存
                
                success(nil,object);
            }
            return task; // 退出从不请求
        }
        default: {
            
            break;
        }
    }
    
    task = [self requestMethod:type URLString:URLString parameters:parameters cache:cache cacheKey:cacheKey success:success failure:failure];
    return task;
}

+ (NSURLSessionDataTask *)requestMethod:(YFNetworkRequestType)type URLString:(NSString *)URLString parameters:(id)parameters cache:(YYCache *)cache cacheKey:(NSString *)cacheKey success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSURLSessionDataTask *task;
    
    switch (type) {
            
        case YFNetworkRequestTypeGET : {
            
            task = [[YFNetworkRequest sharedInstance] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject isKindOfClass:[NSData class]]) {
                    
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                
                [cache setObject:responseObject forKey:cacheKey]; // YYCache 已经做了responseObject为空处理
                success(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure(task, error);
            }];
            break;
        }
        case YFNetworkRequestTypePOST : {
            
            task = [[YFNetworkRequest sharedInstance] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject isKindOfClass:[NSData class]]) {
                    
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                
                [cache setObject:responseObject forKey:cacheKey]; // YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure(task, error);
            }];
            break;
        }
        case YFNetworkRequestTypePUT : {
            
            task = [[YFNetworkRequest sharedInstance] PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject isKindOfClass:[NSData class]]) {
                    
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                
                [cache setObject:responseObject forKey:cacheKey]; // YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure(task, error);
            }];
            break;
        }
        case YFNetworkRequestTypeDELETE : {
            
            task = [[YFNetworkRequest sharedInstance] DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject isKindOfClass:[NSData class]]) {
                    
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                
                [cache setObject:responseObject forKey:cacheKey]; // YYCache 已经做了responseObject为空处理
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure(task, error);
            }];
            break;
        }
        default:
            break;
    }

    return task;
}

#pragma mark - init
+ (instancetype)sharedInstance {
    
    static YFNetworkRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [YFNetworkRequest client];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30.0f;
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil];
    });
    return manager;
}

+ (instancetype)client {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [[YFNetworkRequest alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString] sessionConfiguration:configuration];
}

#pragma mark - 监测网络状态相关
- (Reachability *)reachability {
    
    if (_reachability == nil) {
        
        [kNotificationCenter addObserver:self selector:@selector(networkStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
        
        _reachability = [Reachability reachabilityForInternetConnection];
        [_reachability startNotifier];
    }
    return _reachability;
}

+ (NetworkStatus)getCurrentNetworkStatus {
    
    NetworkStatus networkStatus = [[YFNetworkRequest sharedInstance].reachability currentReachabilityStatus];
    
    return networkStatus;
}

- (void)networkStatusDidChanged:(NSNotification *)notification {
    
    [kNotificationCenter postNotificationName:kNetworkStatusDidChangedNotification object:@([self.reachability currentReachabilityStatus])];
}

#pragma mark - dealloc
- (void)dealloc {
    
    [kNotificationCenter removeObserver:self];
}


@end
