//
//  YFMonthCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/27.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "YFMonthCollectionViewCell.h"
#import "YFDayCollectionViewCell.h"

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
    
    self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
}

- (void)createSubviews {
    
    self.testLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    self.testLabel.textAlignment = NSTextAlignmentCenter;
    self.testLabel.font = [UIFont systemFontOfSize:50];
    [self.contentView addSubview:self.testLabel];
    
    
    self.dayCollectionViewFlowLayout = [UICollectionViewFlowLayout new];
    self.dayCollectionViewFlowLayout.itemSize = CGSizeMake(self.width / 6, self.height / 7);
    self.dayCollectionViewFlowLayout.minimumLineSpacing = 0;
    self.dayCollectionViewFlowLayout.minimumInteritemSpacing = 0;
    self.dayCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
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
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    
    return cell;
}

- (void)setDate:(NSDate *)date {
    
    _date = date;
    
    self.testLabel.text = [NSString stringWithFormat:@"%@", date];
}

@end
