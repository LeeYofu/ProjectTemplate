//
//  BaseTableViewCell.m
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/14.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    
}

@end