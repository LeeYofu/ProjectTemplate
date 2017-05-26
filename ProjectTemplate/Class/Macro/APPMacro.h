//
//  APPMarco.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#ifndef APPMacro_h
#define APPMacro_h

/**
 *  本类放一些第三方常量 例如友盟...或者是否第一次启动，用户信息key等
 */

#define kIsDebug YES
//#define kIsDebug NO

#define kMobClickKey @"" // 友盟统计app key
#define kJSPatchKey @"" // JSPatch热修复 key





typedef NS_ENUM(NSInteger, EmptyDataType) {
    
    EmptyDataType_Loading,
    EmptyDataType_NoData,
    EmptyDataType_NetworkError
};

#endif /* APPMarco_h */


