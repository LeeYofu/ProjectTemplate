//
//  YFSecurityUtil.m
//  test
//
//  Created by 李友富 on 16/1/4.
//  Copyright © 2016年 李友富. All rights reserved.
//

#import "YFSecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+YFAES.h"
#import "NSString+YFDES.h"
#import "NSString+YFMD5_Sha.h"

@implementation YFSecurityUtil

#pragma mark - MD5加密
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)inputString {
    
    return [inputString getMd5_16Bit_String];
}

//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)inputString {
    
    return [inputString getMd5_32Bit_String];
}

#pragma mark - SHA加密
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)inputString {
    
    return [inputString getSha1String];
}

//sha256加密方式
+ (NSString *)getSha256String:(NSString *)inputString {
   
    return [inputString getSha256String];
}

//sha384加密方式
+ (NSString *)getSha384String:(NSString *)inputString {
    
    return [inputString getSha384String];
}

//sha512加密方式
+ (NSString *)getSha512String:(NSString *)inputString {
   
    return [inputString getSha512String];
}

#pragma mark - base64编解码
+ (NSString *)getEncodeBase64String:(NSString *)inputString {
    
    NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)getDecodeBase64String:(NSString *)inputString {
    
    NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)getEncodeBase64Data:(NSData *)inputData {
    
    inputData = [GTMBase64 encodeData:inputData];
    NSString *base64String = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)getDecodeBase64Data:(NSData *)inputData {
    
    inputData = [GTMBase64 decodeData:inputData];
    NSString *base64String = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - AES加解密
//将string转成带密码的data
+ (NSData *)getEncryptAESString:(NSString *)inputString {
    
    //将nsstring转化为nsdata
    NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data getAES256EncryptWithKey:kEncrypt_DecryptAESPublicPassword];
    return encryptedData;
}

//将带密码的data转成string
+ (NSString*)getDecryptAESData:(NSData *)inputData {
    
    //使用密码对data进行解密
    NSData *decryData = [inputData getAES256DecryptWithKey:kEncrypt_DecryptAESPublicPassword];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

#pragma mark - DES加解密
+ (NSString *)getEncryptDESString:(NSString *)inputString {
    
    return [inputString getDESEncryptWithKey:kEncrypt_DecryptDESPublicPassword];
}

+ (NSString *)getDecryptDESString:(NSString *)inputString {
    
    return [inputString getDESDecryptWithKey:kEncrypt_DecryptDESPublicPassword];
}

@end
