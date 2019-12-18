//
//  SKTitleLabel.m
//  CelestiaClient
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019年 sunke. All rights reserved.
//

#import "SKTitleLabel.h"

@interface SKTitleLabel()
{
    CGContextRef _context;
}
@end

@implementation SKTitleLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
//        self.scale = 1.0;
        // 文字颜色
//        self.textColor = [UIColor darkGrayColor];
        //self.highlightedTextColor = THEMERED;
    }
    return self;
}

- (void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
    self.textColor = selectColor;
    
}

/** 通过scale的改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;

    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];

//    CGFloat minScale = 0.7;
//    CGFloat trueScale = minScale + (1-minScale)*scale;
//    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    
}

/*
- (void)setUnderlineColour:(UIColor *)underlineColour{
    _underlineColour = underlineColour;
    [self setNeedsDisplay];
}
- (void)setUnderlineWidth:(CGFloat)underlineWidth{
    _underlineWidth = underlineWidth;
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setUnderlineType:(UnderlineType)underlineType{
    _underlineType = underlineType;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    //记住调用父类的此方法，不然无法将无法显示文字
    [super drawRect:rect];
    
    // 创建图形上下文
    _context = UIGraphicsGetCurrentContext();
    
    // 开启图形上下文
    CGContextBeginPath(_context);
    
    // 设置下划线颜色
    CGContextSetStrokeColorWithColor(_context, _underlineColour ? _underlineColour.CGColor : [UIColor blackColor].CGColor);
    
    // 设置下划线的宽度
    CGContextSetLineWidth(_context, _underlineWidth ? _underlineWidth : 1);
    
    // 设置下划线的线型
    CGContextSetLineCap(_context, kCGLineCapRound);
    
    //设置下划线样式
    if (_underlineType) {//x线
        [self drawLineWithBeginPoint:CGPointMake(0, 0) endPoint:CGPointMake(rect.size.width, rect.size.height)];
        [self drawLineWithBeginPoint:CGPointMake(0, rect.size.height) endPoint:CGPointMake(rect.size.width, 0)];
    }else{//横线
        [self drawLineWithBeginPoint:CGPointMake(0, rect.size.height - _underlineWidth) endPoint:CGPointMake(rect.size.width, rect.size.height - _underlineWidth)];
    }
}
- (void)drawLineWithBeginPoint:(CGPoint )start endPoint:(CGPoint )end{
    // 设置起点
    CGContextMoveToPoint(_context, start.x,start.y);
    // 设置下一个连接点
    CGContextAddLineToPoint(_context, end.x, end.y);
    // 画图
    CGContextStrokePath(_context);
}

*/


@end
