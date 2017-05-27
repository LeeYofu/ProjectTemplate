//
//  YFMonthCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFMonthCollectionViewCell.h"
#import "YFDayCollectionViewCell.h"
#import "NSDate+YFCalendar.h"

@interface YFMonthCollectionViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *testLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *dayCollectionViewFlowLayout;
@property (nonatomic, strong) UICollectionView *dayCollectionView;

@end

@implementation YFMonthCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

- (void)config {
    
    self.backgroundColor = kWhiteColor;
}

- (void)createSubviews {
    
    self.testLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    self.testLabel.textAlignment = NSTextAlignmentCenter;
    self.testLabel.font = [UIFont systemFontOfSize:50];
    [self.contentView addSubview:self.testLabel];
    
    
    self.dayCollectionViewFlowLayout = [UICollectionViewFlowLayout new];
    self.dayCollectionViewFlowLayout.itemSize = CGSizeMake(self.width / 7, self.height / 6);
    self.dayCollectionViewFlowLayout.minimumLineSpacing = 0;
    self.dayCollectionViewFlowLayout.minimumInteritemSpacing = 0;
    self.dayCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.dayCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.dayCollectionViewFlowLayout];
    self.dayCollectionView.delegate = self;
    self.dayCollectionView.dataSource = self;
    self.dayCollectionView.pagingEnabled = YES;
    self.dayCollectionView.showsHorizontalScrollIndicator = NO;
    self.dayCollectionView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.dayCollectionView];
    
    [self.dayCollectionView registerClass:[YFDayCollectionViewCell class] forCellWithReuseIdentifier:@"dayCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YFDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    
    NSInteger firstWeekday = [self.date firstWeekDayInMonth];
    NSInteger totalDays = [self.date totalDaysInMonth];
    
    if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
        
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
        cell.dayLabel.textColor = [UIColor darkTextColor];
        
//        // 标识今天
        if (([self.date getMonth] == [[NSDate date] getMonth]) && ([self.date getYear] == [[NSDate date] getYear])) {
            
            if (indexPath.row == [[NSDate date] getDay] + firstWeekday - 1) {
                
                cell.todayView.backgroundColor = kRedColor;
                cell.dayLabel.textColor = [UIColor whiteColor];
            } else {
                
                cell.todayView.backgroundColor = [UIColor clearColor];
            }
        } else {
            
            cell.todayView.backgroundColor = [UIColor clearColor];
        }
        cell.userInteractionEnabled = YES;

    } else if (indexPath.row < firstWeekday) {
        
        NSInteger totalDaysOflastMonth = [[self.date lastMonthDate] totalDaysInMonth];
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
        cell.dayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        cell.todayView.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = NO;
    } else if (indexPath.row >= firstWeekday + totalDays) {
        
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
        cell.dayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        cell.todayView.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = NO;
    } else {
        
        
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YFDayCollectionViewCell *cell = (YFDayCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@-%@", self.date, cell.dayLabel.text);
}

- (void)setDate:(NSDate *)date {
    
    _date = date;
    
    [self.dayCollectionView reloadData];
}

@end
