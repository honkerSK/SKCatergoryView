//
//  SKTitleView.h
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//

//滚动标题栏
#import <UIKit/UIKit.h>
#import "SKCatergoryConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKTitleView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame config:(SKCatergoryConfig *)config;

///点击标题按钮 回调label的tag
@property (nonatomic, copy) void (^titleLableBlock)(NSInteger tag);

///设置下划线x偏移
- (void)setTitleUnderlineWitOffsetLineX:(CGFloat)offsetLineX;
///获取所有子视图
- (NSArray *)getSubviews;

@end

NS_ASSUME_NONNULL_END
