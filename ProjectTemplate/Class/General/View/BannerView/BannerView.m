//
//  BannerView.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/5/26.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BannerView.h"
#import "BannerViewCollectionViewCell.h"

static NSString *identifier = @"bannerImageCell";

@interface BannerView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *handledImageURLStrArray;
@property (nonatomic, weak) id<BannerViewDelegate> delegete;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BannerView

- (NSMutableArray *)handledImageURLStrArray {
    
    if (_handledImageURLStrArray == nil) {
        
        _handledImageURLStrArray = [NSMutableArray new];
    }
    return _handledImageURLStrArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self config];
        [self createSubviews];
    }
    return self;
}

+ (instancetype)bannerViewWithFrame:(CGRect)frame delegate:(id)delegate autoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    
    BannerView *bannerView = [[self alloc] initWithFrame:frame];
    
    bannerView.delegete = delegate;
    bannerView.autoScrollTimeInterval = autoScrollTimeInterval;
    
    return bannerView;
}

- (void)config {
    
    
}

- (void)createSubviews {
    
    self.collectionViewFlowLayout = [UICollectionViewFlowLayout new];
    self.collectionViewFlowLayout.itemSize = CGSizeMake(self.width, self.height);
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionViewFlowLayout.minimumLineSpacing = 0;
    self.collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[BannerViewCollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

- (void)startTimer {
    
    if (self.timer == nil && self.autoScrollTimeInterval > 0) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction {
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.collectionView.width, 0) animated:YES];
    
    // 主动调用以下代理方法；
    [self scrollViewDidEndDecelerating:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.handledImageURLStrArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BannerViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.imageURLStr = self.handledImageURLStrArray[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float contentOffsetScrolledRight = self.collectionView.width * ([self.handledImageURLStrArray count] -1);
    if (scrollView.contentOffset.x == contentOffsetScrolledRight) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.width, 0) animated:NO];
    } else if (scrollView.contentOffset.x == 0) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.handledImageURLStrArray.count - 2 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.width * (self.handledImageURLStrArray.count - 2), 0) animated:NO];
    }
}

- (void)setImageURLStrArray:(NSArray<NSString *> *)imageURLStrArray {
    
    _imageURLStrArray = imageURLStrArray;
    
    [self.handledImageURLStrArray removeAllObjects];
    [self.handledImageURLStrArray addObjectsFromArray:imageURLStrArray];
    [self.handledImageURLStrArray insertObject:imageURLStrArray.lastObject atIndex:0];
    [self.handledImageURLStrArray addObject:imageURLStrArray.firstObject];
    
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.collectionView.scrollEnabled = imageURLStrArray.count > 1;
    
    if (imageURLStrArray.count > 1) {
        
        [self startTimer];
    }
}

@end
