//
//  TestCollectionViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/8/17.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

- (void)createSubviews {
    
    [super createSubviews];
    
    self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = kFont(50);
    [self.contentView addSubview:self.label];
}

- (void)setRow:(NSInteger)row {
    
    _row = row;
    
    self.label.text = [NSString stringWithFormat:@"%ld", row];
}

- (void)setSelectedRow:(NSInteger)selectedRow {
    
    _selectedRow = selectedRow;
    
//    if (selectedRow == self.row) {
//        
//        NSLog(@"类型%ld需要实时监控数据 + 请求最新数据", self.row);
//    } else {
//        
//        NSLog(@"类型%ld断开长连接", self.row);
//    }
}

@end
