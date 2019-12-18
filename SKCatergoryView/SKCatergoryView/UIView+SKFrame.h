//
//  UIView+SKFrame.h
//  sunke的分类
//
//  Created by sunke on 2017/7/23.
//  Copyright © 2017年 SK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SKFrame)

@property (nonatomic, assign) CGFloat sk_width;
@property (nonatomic, assign) CGFloat sk_height;
@property (nonatomic, assign) CGFloat sk_x;
@property (nonatomic, assign) CGFloat sk_y;
@property (nonatomic, assign) CGFloat sk_centerX;
@property (nonatomic, assign) CGFloat sk_centerY;
@property (nonatomic, assign) CGSize sk_size;
@property (nonatomic, assign) CGPoint sk_origin;


//xib加载
+ (instancetype)sk_viewFromXib;

///获取当前类名
+ (NSString *)getClassName;


@end
