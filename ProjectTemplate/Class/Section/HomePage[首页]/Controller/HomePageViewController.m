//
//  HomePageViewController.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/8/15.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "HomePageViewController.h"
#import "TestCollectionViewCell.h"
#import <MJRefresh.h>

static NSString *identifier = @"cell";

@interface HomePageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)config {
    
    [super config];
    
    self.dataArray = [NSMutableArray new];
    
    NSArray *originArray = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, nil];
    
    NSInteger index = 5; // @6
    
    self.index = index + 1;
    
    self.dataArray = [NSMutableArray arrayWithArray:originArray];
    
    [self.dataArray insertObject:originArray.lastObject atIndex:0];
    [self.dataArray addObject:originArray.firstObject];
}

- (void)createSubviews {
    
    [super createSubviews];
    
    self.collectionViewFlowLayout = [UICollectionViewFlowLayout new];
    self.collectionViewFlowLayout.itemSize = CGSizeMake(self.view.width, self.view.height);
    self.collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionViewFlowLayout.minimumLineSpacing = 0;
    self.collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
    self.collectionView.backgroundColor = kYellowColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:identifier];

//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
//    self.collectionView.directionalLockEnabled = YES;
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.row = [self.dataArray[indexPath.row] integerValue];
    cell.selectedRow = [self.dataArray[self.index] integerValue];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    if (self.collectionView.contentOffset.x == 0) {
//        
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    }
//    
//    if (self.collectionView.contentOffset.x == (self.dataArray.count - 1) * self.collectionView.width) {
//        
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
//    }
//    
//    NSInteger currentRow = self.collectionView.contentOffset.x / self.collectionView.width;
//    
//    self.index = currentRow;
}



@end
