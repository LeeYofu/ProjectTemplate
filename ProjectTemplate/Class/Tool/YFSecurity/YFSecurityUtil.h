//
//  YFSecurityUtil.h
//  test
//
//  Created by 李友富 on 16/1/4.
//  Copyright © 2016年 李友富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFSecurityUtil : NSObject

// arc 报错  GTMBase64.m 添加 -fno-objc-arc
// 导入头文件  YFSecurityUtil.h 即可使用
// QQ 390806992

#define kAESEncrypt_DecryptPublicPassword @"liyoufu" // AES加解密密码
#define kDESEncrypt_DecryptPublicPassword @"liyoufu" // DES加解密密码

#pragma mark - 【MD5加密】
// 16位MD5加密方式
+ (NSString *)getMd5_16Bit_StringWithString:(NSString *)inputString;
// 32位MD5加密方式
+ (NSString *)getMd5_32Bit_StringWithString:(NSString *)inputString;

#pragma mark - 【SHA加密】
// sha1加密方式
+ (NSString *)getSha1StringWithString:(NSString *)inputString;
// sha256加密方式
+ (NSString *)getSha256StringWithString:(NSString *)inputString;
// sha384加密方式
+ (NSString *)getSha384StringWithString:(NSString *)inputString;
// sha512加密方式
+ (NSString *)getSha512StringWithString:(NSString *)inputString;

#pragma mark - 【base64编解码】
+ (NSString *)getBase64EncodeStringWithString:(NSString *)inputString;
+ (NSString *)getBase64DecodeStringWithString:(NSString *)inputString;
+ (NSString *)getBase64EncodeStringWithData:(NSData *)inputData;
+ (NSString *)getBase64DecodeStringWithData:(NSData *)inputData;

#pragma mark - 【AES加解密】
// 将string转成带密码的data
+ (NSData *)getAESEncryptDataWithString:(NSString *)inputString;
// 将带密码的data转成string
+ (NSString *)getAESDecryptStringWithData:(NSData *)inputData;

#pragma mark - 【DES加解密】
// 将不带密码string转成带密码的string（加密）
+ (NSString *)getDESEncryptStringWithString:(NSString *)inputString;
// 将带密码的string转换成不带密码的string（解密）
+ (NSString *)getDESDecryptStringWithString:(NSString *)inputString;

@end
