//
//  SKCatergoryConfig.h
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//
// 配置对象
#import <Foundation/Foundation.h>
@class SKTitleView,SKScrollView;


NS_ASSUME_NONNULL_BEGIN

@interface SKCatergoryConfig : NSObject

/// ********  必须属性 ********
//@property (nonatomic ,strong) SKTitleView *titleView; // 标题栏scrollView
//@property (nonatomic, strong) SKScrollView *scrollView; //底部scrollView

@property (nonatomic,strong) NSArray <NSString *>*titles;  //分类数组
@property (nonatomic,weak) UIViewController *viewController; // 容器控制器
@property (nonatomic,strong) NSArray *viewControllers; //子控制器数组

/// ********  可选属性 ********
///标题栏宽度
@property (nonatomic, assign) CGFloat titleViewWidth;
///标题栏高度
@property (nonatomic, assign) CGFloat titleViewHeight;
///标题间距 (默认20)
@property (nonatomic, assign) CGFloat titleViewMargin;
///标题栏背景色 (默认白色)
@property (nonatomic, strong) UIColor *titleViewBackgroudColor;
///标题栏默认文字颜色 (默认黑色)
@property (nonatomic, strong) UIColor *textColor;
///标题栏选中文字颜色 (默认红色)
@property (nonatomic, strong) UIColor *selectTextColor;

///标题栏文字字号
@property (nonatomic, strong) UIFont *titleViewFont;

///下划线线宽(默认20)
@property (nonatomic, assign) CGFloat lineWidth;
///下划线高度(默认2)
@property (nonatomic, assign) CGFloat lineHeight;
///下划线颜色
@property (nonatomic, strong) UIColor *lineColor;
///下划线相对于titleView y方向位置 (默认在titleView底部)
@property (nonatomic, assign) CGFloat lineY;
///下划线相对于titleView x方向偏移量(默认0 ,和titleView左边对齐)
@property (nonatomic, assign) CGFloat offsetLineX;


@end

NS_ASSUME_NONNULL_END
