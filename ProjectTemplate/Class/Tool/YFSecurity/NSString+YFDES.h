//
//  NSString+YFDES.h
//  SecurityTest
//
//  Created by 李友富 on 2016/12/21.
//  Copyright © 2016年 李友富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YFDES)

- (NSString *)getDESEncryptWithKey:(NSString *)key;   // 加密
- (NSString *)getDESDecryptWithKey:(NSString *)key;   // 解密

@end
