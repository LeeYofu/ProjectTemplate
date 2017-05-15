//
//  CustomNavigationBar.h
//  ProjectTemplate
//
//  Created by 李友富 on 2017/2/15.
//  Copyright © 2017年 李友富. All rights reserved.
//

#import "BaseView.h"

@protocol CustomNavigationBarDelegate <NSObject>

@optional

- (void)navigationBarBackButtonDidClicked;

@end

@interface CustomNavigationBar : BaseView

@property (nonatomic, weak) id<CustomNavigationBarDelegate> delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL backButtonHidden;

@end
