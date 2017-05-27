//
//  NSDate+YFCalendar.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YFCalendar)

- (NSDate *)lastMonthDate;
- (NSDate *)nextMonthDate;
- (NSInteger)getDay;
- (NSInteger)getMonth;
- (NSInteger)getYear;
@end
