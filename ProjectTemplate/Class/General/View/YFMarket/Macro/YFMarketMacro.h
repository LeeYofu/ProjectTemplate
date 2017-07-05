//
//  YFMarketMacro.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/7/5.
//  Copyright © 2017年 李友富. All rights reserved.
//

#ifndef YFMarketMacro_h
#define YFMarketMacro_h












// 线的类型
typedef NS_ENUM(NSInteger, YFMarketLineType) {
    
    YFMarketLineType_TimeLine,
    YFMarketLineType_KLine
};

// 线的具体类型
typedef NS_ENUM(NSInteger, YFMarketLineDetailType) {
    
    YFMarketLineDetailType_MinuteHour,
    YFMarketLineDetailType_DayK,
    YFMarketLineDetailType_WeekK,
    YFMarketLineDetailType_MonthK,
    YFMarketLineDetailType_5Minute,
    YFMarketLineDetailType_30Minute,
    YFMarketLineDetailType_60Minute,
    YFMarketLineDetailType_YearK
};

#define kMarketLineDetailTypeTitleArray @[ @"分时", @"日K", @"周K", @"月K", @"5分", @"30分", @"60分", @"年K" ]

// K线指标类型
typedef NS_ENUM(NSInteger, YFKLineIndexType) {
    
    YFKLineIndexType_MACD,
    YFKLineIndexType_KDJ,
    YFKLineIndexType_RSI,
    YFKLineIndexType_ARBR,
    YFKLineIndexType_OBV,
    YFKLineIndexType_WR,
    YFKLineIndexType_EMV,
    YFKLineIndexType_DMA,
    YFKLineIndexType_CCI,
    YFKLineIndexType_BIAS,
    YFKLineIndexType_ROC,
    YFKLineIndexType_MTM,
    YFKLineIndexType_CR,
    YFKLineIndexType_DMI,
    YFKLineIndexType_VR,
    YFKLineIndexType_TRIX,
    YFKLineIndexType_PSY,
    YFKLineIndexType_DPO,
    YFKLineIndexType_ASI,
    YFKLineIndexType_SAR
};

#define kKLineIndexTypeTitleArray @[ @"MACD", @"KDJ", @"RSI", @"ARBR", @"OBV", @"WR", @"EMV", @"DMA", @"CCI", @"BIAS", @"ROC", @"MTM", @"CR", @"DMI", @"VR", @"TRIX", @"PSY", @"DPO", @"ASI", @"SAR" ]



#endif /* YFMarketMacro_h */
