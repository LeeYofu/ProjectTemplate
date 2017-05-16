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
};

static NSString * const YFNetworkRequestCache = @"YFNetworkRequestCache";

@implementation YFNetworkRequest

#pragma mark - public
+ (NSURLSessionDataTask *)getWithSubUrl:(NSString *)subUrlString
           parameters:(id)parameters
               sucess:(SucessBlock)sucess
              failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeGET subUrlString:subUrlString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:sucess failure:failure];
}

+ (NSURLSessionDataTask *)getWithSubUrl:(NSString *)subUrlString
           parameters:(id)parameters
          cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy
               sucess:(SucessBlock)sucess
              failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypeGET subUrlString:subUrlString parameters:parameters cachePolicy:requestCachePolicy success:sucess failure:failure];
}

+ (NSURLSessionDataTask *)postWithSubUrl:(NSString *)subUrlString
            parameters:(id)parameters
                sucess:(SucessBlock)sucess
               failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePOST subUrlString:subUrlString parameters:parameters cachePolicy:YFNetworkRequestReloadIgnoringLocalCacheData success:sucess failure:failure];
}

+ (NSURLSessionDataTask *)postWithSubUrl:(NSString *)subUrlString
            parameters:(id)parameters
           cachePolicy:(YFNetworkRequestCachePolicy)requestCachePolicy
                sucess:(SucessBlock)sucess
               failure:(FailureBlock)failure {
    
    return [self requestMethod:YFNetworkRequestTypePOST subUrlString:subUrlString parameters:parameters cachePolicy:requestCachePolicy success:sucess failure:failure];
}

// 上传视频/图片
+ (NSURLSessionDataTask *)postWithSubUrl:(NSString *)subUrl
            parameters:(id)parameters
            imageDatas:(NSArray *)imageDatas
            imageNames:(NSArray *)imageNames
             videoData:(NSData *)videoData
                sucess:(SucessBlock)sucess
                failed:(FailureBlock)failure {
    
    return [[YFNetworkRequest sharedInstance] POST:subUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageDatas.count; i++) {
            
            [formData appendPartWithFileData:[imageDatas objectAtIndex:i]
                                        name:[imageNames objectAtIndex:i]
                                    fileName:[NSString stringWithFormat:@"%@.jpg",[imageNames objectAtIndex:i]]
                                    mimeType:@"image/jpeg"];
            
        }
        
        if (videoData) {
            
            [formData appendPartWithFileData:videoData
                                        name:@"video"
                                    fileName:[NSString stringWithFormat:@"%@.mp4",@"video"]
                                    mimeType:@"video/mp4"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (sucess) {
            
            sucess(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(task, error);
        }
    }];

}

#pragma mark - private
+ (NSURLSessionDataTask *)requestMethod:(YFNetworkRequestType)type
         subUrlString:(NSString *)subUrlString parameters:(id)parameters
          cachePolicy:(YFNetworkRequestCachePolicy)cachePolicy
              success:(SucessBlock)success
              failure:(FailureBlock)failure {
    
    NSURLSessionDataTask *task;
    
    NSString *cacheKey = subUrlString;
    
    if (parameters) {
        
        if (! [NSJSONSerialization isValidJSONObject:parameters]) return task;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [subUrlString stringByAppendingString:paramStr];
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
    
    task = [self requestMethod:type subUrlString:subUrlString parameters:parameters cache:cache cacheKey:cacheKey success:success failure:failure];
    return task;
}

+ (NSURLSessionDataTask *)requestMethod:(YFNetworkRequestType)type
            subUrlString:(NSString *)subUrlString
           parameters:(id)parameters
                cache:(YYCache *)cache
             cacheKey:(NSString *)cacheKey
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSURLSessionDataTask *task;
    
    switch (type) {
            
        case YFNetworkRequestTypeGET : {
            
            task = [[YFNetworkRequest sharedInstance] GET:subUrlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
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
            
            task = [[YFNetworkRequest sharedInstance] POST:subUrlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
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
    return [[YFNetworkRequest alloc] initWithBaseURL:[NSURL URLWithString:BASEURLSTRING] sessionConfiguration:configuration];
}


@end
