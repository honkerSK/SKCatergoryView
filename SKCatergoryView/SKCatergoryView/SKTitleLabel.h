//
//  SKTitleLabel.h
//  CelestiaClient
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019年 sunke. All rights reserved.
//

// 标题栏 label
#import <UIKit/UIKit.h>
// 打开scale 属性实现放大效果
NS_ASSUME_NONNULL_BEGIN

typedef enum {
    UnderlineTypeLine, //下划线
    UnderlineTypeX //x划线
} UnderlineType;

@interface SKTitleLabel : UILabel

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic, strong) UIColor *selectColor;

//下划线颜色
@property (nonatomic ,strong) UIColor *underlineColour;
//下划线宽度
@property (nonatomic ,assign) CGFloat underlineWidth;
//下划线的样式
@property (nonatomic ,assign) UnderlineType underlineType;

@end

NS_ASSUME_NONNULL_END
