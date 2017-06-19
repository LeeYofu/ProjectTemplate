//
//  YFCalendarView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFCalendarView.h"
#import "YFMonthCollectionViewCell.h"
#import "NSDate+YFCalendar.h"

@interface YFCalendarView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger numberOfDaysInARow;
@property (nonatomic, assign) CGFloat dayItemWidthHeight;
@property (nonatomic, assign) CGFloat dateViewHeight;
@property (nonatomic, assign) CGFloat weekViewHeight;
@property (nonatomic, assign) NSInteger dayRowCount;
@property (nonatomic, assign) CGFloat monthViewHeight;
@property (nonatomic, assign) CGFloat mainViewHeight;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, assign) NSInteger monthCount;
@property (nonatomic, strong) NSMutableArray *allMonthDateArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIView *weekView;
@property (nonatomic, strong) UIView *monthView;
@property (nonatomic, strong) UICollectionViewFlowLayout *monthCollectionFlowLayout;
@property (nonatomic, strong) UICollectionView *monthCollectionView;


@end

@implementation YFCalendarView

- (NSMutableArray *)allMonthDateArray {
    
    if (_allMonthDateArray == nil) {
        
        _allMonthDateArray = [NSMutableArray new];
    }
    return _allMonthDateArray;
}

+ (instancetype)calendarViewWithFrame:(CGRect)frame {
    
    YFCalendarView *calendarView = [[YFCalendarView alloc] initWithFrame:frame];
    
    return calendarView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self config];
        [self createSubviews];
        [self addTapGesture];
    }
    return self;
}

- (void)config {
    
    self.frame = CGRectMake(0, self.y, kScreenWidth, kScreenHeight - self.y);
    self.hidden = YES;
    
    self.numberOfDaysInARow = 7;
    self.dayItemWidthHeight = self.width / self.numberOfDaysInARow;
    self.dateViewHeight = 60;
    self.weekViewHeight = 30;
    self.dayRowCount = 6;
    self.monthViewHeight = self.dayItemWidthHeight * self.dayRowCount;
    self.mainViewHeight = self.dateViewHeight + self.weekViewHeight + self.monthViewHeight;
    
    NSDate *todayDate = [NSDate date];
    NSInteger todayDateIndex = 0;
    self.startDate = [NSDate dateWithTimeIntervalSince1970:0];
    self.monthCount = 10000;
//    NSLog(@"1");
    [self.allMonthDateArray removeAllObjects];
    
    NSDate *tempDate = self.startDate;
    for (int i = 0; i < self.monthCount; i ++) {
        
        [self.allMonthDateArray addObject:tempDate];
        
        if ([todayDate getYear] == [tempDate getYear] && [todayDate getMonth] == [tempDate getMonth]) {
            
            todayDateIndex = i;
        }
        
        tempDate = [tempDate nextMonthDate];
    }
//    NSLog(@"2");
    self.selectedIndex = todayDateIndex;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex;
    
    // 重新setter 让集合视图滚动到指定位置，因为代码先后顺序原因
}

- (void)createSubviews {
    
    // 底部遮罩
    self.maskView = [[UIView alloc] initWithFrame:self.bounds];
    self.maskView.backgroundColor = kBlackColor;
    self.maskView.alpha = 0.0f;
    [self addSubview:self.maskView];
    
    // 顶部主视图/背景
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    self.mainView.clipsToBounds = YES;
    [self addSubview:self.mainView];
    
    // 日期选择器
    self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.dateViewHeight)];
    self.dateView.backgroundColor = kThemeColor;
    [self.mainView addSubview:self.dateView];
    
    // 周指示器
    self.weekView = [[UIView alloc] initWithFrame:CGRectMake(0, self.dateView.maxY, self.width, self.weekViewHeight)];
    self.weekView.backgroundColor = kThemeColor;
    [self.mainView addSubview:self.weekView];
    
    CGFloat weekLabelWidth = self.weekView.width / 7;
    NSArray *weekTitleArray = @[
                                @"日",
                                @"一",
                                @"二",
                                @"三",
                                @"四",
                                @"五",
                                @"六"
                                ];
    for (int i = 0; i < 7; i ++) {
        
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * weekLabelWidth, 0, weekLabelWidth, self.weekView.height)];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = kFont_13;
        weekLabel.textColor = kWhiteColor;
        weekLabel.text = weekTitleArray[i];
        [self.weekView addSubview:weekLabel];
    }
    
    // 月/日选择器
    self.monthView = [[UIView alloc] initWithFrame:CGRectMake(0, self.weekView.maxY, self.width, self.monthViewHeight)];
    self.monthView.backgroundColor = kYellowColor;
    [self.mainView addSubview:self.monthView];

    self.monthCollectionFlowLayout = [UICollectionViewFlowLayout new];
    self.monthCollectionFlowLayout.itemSize = CGSizeMake(self.monthView.width, self.monthView.height);
    self.monthCollectionFlowLayout.minimumLineSpacing = 0;
    self.monthCollectionFlowLayout.minimumInteritemSpacing = 0;
    self.monthCollectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.monthCollectionView = [[UICollectionView alloc] initWithFrame:self.monthView.bounds collectionViewLayout:self.monthCollectionFlowLayout];
    self.monthCollectionView.delegate = self;
    self.monthCollectionView.dataSource = self;
    self.monthCollectionView.pagingEnabled = YES;
    self.monthCollectionView.showsHorizontalScrollIndicator = NO;
    self.monthCollectionView.backgroundColor = kWhiteColor;
    [self.monthView addSubview:self.monthCollectionView];
    
    [self.monthCollectionView registerClass:[YFMonthCollectionViewCell class] forCellWithReuseIdentifier:@"monthCell"];
    
    [self.monthCollectionView setContentOffset:CGPointMake(self.selectedIndex * self.monthCollectionView.width, 0)];
}

- (void)addTapGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.maskView addGestureRecognizer:tap];
}

- (void)tapAction {
    
    [self hide];
}

- (void)show {
    
    self.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
       
        self.mainView.height = self.mainViewHeight;
        self.maskView.alpha = 0.4f;
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.mainView.height = 0;
        self.maskView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allMonthDateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YFMonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"monthCell" forIndexPath:indexPath];
    
    cell.date = self.allMonthDateArray[indexPath.item];
    
    return cell;
}

@end
