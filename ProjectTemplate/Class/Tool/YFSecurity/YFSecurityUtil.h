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

#define kEncrypt_DecryptAESPublicPassword @"liyoufu" // AES加解密密码
#define kEncrypt_DecryptDESPublicPassword @"liyoufu" // DES加解密密码

#pragma mark - 【MD5加密】
// 16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)inputString;
// 32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)inputString;

#pragma mark - 【SHA加密】
// sha1加密方式
+ (NSString *)getSha1String:(NSString *)inputString;
// sha256加密方式
+ (NSString *)getSha256String:(NSString *)inputString;
// sha384加密方式
+ (NSString *)getSha384String:(NSString *)inputString;
// sha512加密方式
+ (NSString *)getSha512String:(NSString *)inputString;

#pragma mark - 【base64编解码】
+ (NSString *)getEncodeBase64String:(NSString *)inputString;
+ (NSString *)getDecodeBase64String:(NSString *)inputString;
+ (NSString *)getEncodeBase64Data:(NSData *)inputData;
+ (NSString *)getDecodeBase64Data:(NSData *)inputData;

#pragma mark - 【AES加解密】
// 将string转成带密码的data
+ (NSData *)getEncryptAESString:(NSString *)inputString;
// 将带密码的data转成string
+ (NSString *)getDecryptAESData:(NSData *)inputData;

#pragma mark - 【DES加解密】
// 将不带密码string转成带密码的string（加密）
+ (NSString *)getEncryptDESString:(NSString *)inputString;
// 将带密码的string转换成不带密码的string（解密）
+ (NSString *)getDecryptDESString:(NSString *)inputString;

@end
