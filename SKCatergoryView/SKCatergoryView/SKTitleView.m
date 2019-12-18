//
//  SKTitleView.m
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//

#import "SKTitleView.h"
#import "Masonry.h"
#import "SKCatergoryConfig.h"

#import "SKTitleLabel.h"
#import "UIView+SKFrame.h"

@interface SKTitleView()


@property (nonatomic, strong) SKCatergoryConfig *config;
///过渡视图
@property (nonatomic ,weak) UIView *containerView;
///下划线
@property (nonatomic, weak) UIView *titleUnderline;
///上次点击的label
@property (nonatomic, strong) SKTitleLabel *previousClickedTitleLabel;

@end

@implementation SKTitleView


- (NSArray *)getSubviews{
    return self.containerView.subviews;
}


- (void)setTitleUnderlineWitOffsetLineX:(CGFloat)offsetLineX{
    [UIView animateWithDuration:0.25 animations:^{
        self.titleUnderline.sk_x = offsetLineX;
    } completion:^(BOOL finished) {
    }];
}


- (instancetype)initWithFrame:(CGRect)frame config:(SKCatergoryConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self createView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self createView];
//    }
//    return self;
//}

- (void)createView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = self.config.titleViewBackgroudColor;
    self.pagingEnabled = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.scrollsToTop = NO; // 点击状态栏不滚动到顶部
    
    // 1.添加SKTitleView的子视图，即过渡视图contentSize，并设置其约束
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    self.containerView = containerView;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.config.titleViewHeight);
    }];
    
    //2.过渡视图添加子视图 SKTitleLabel
    UIView *previousView = nil;
    CGFloat marginX = self.config.titleViewMargin;
    for (int i = 0; i < self.config.titles.count; i++) {
        SKTitleLabel *label = [[SKTitleLabel alloc] init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.textColor = self.config.textColor; //开始默认颜色
        label.font = self.config.titleViewFont; //标题字体
        label.text = self.config.titles[i];
//        [label sizeToFit];
        
        // 添加到父视图，并设置过渡视图中子视图的约束
        [containerView addSubview:label];
        
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLableClick:)]];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(containerView);
            if (previousView) { //有上一个视图
                make.left.equalTo(previousView.mas_right).offset(marginX); //每个标题间距20
            }else {
                make.left.mas_equalTo(0);
            }
        }];
        previousView = label;
    }
    //3.设置过渡视图的右距（此设置将影响到scrollView的contentSize）
    [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(previousView.mas_right); //与最后一个视图右边对齐
    }];
    
    //4.首个SKTitleLabel 颜色
    UIView *labelView = [self.containerView.subviews firstObject];
    SKTitleLabel *label = (SKTitleLabel *)labelView;
    //label.scale = 0.7;
    label.textColor = self.config.selectTextColor;
    self.previousClickedTitleLabel = label;
    
    //5.添加下划线容器titlelineView 到SKTitleView
    //下划线容器titlelineView, 和 SKTitleView等宽
    UIView *titlelineView = [[UIView alloc] init];
    [self addSubview:titlelineView];
    titlelineView.backgroundColor = [UIColor clearColor];
    
    [titlelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.config.lineY);
//        make.bottom.mas_equalTo(-4);
        make.height.mas_equalTo(weakSelf.config.lineHeight);
    }];
    
    //下划线view 添加到titlelineView
    UIView *titleUnderline = [[UIView alloc] init];
    [titlelineView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    titleUnderline.backgroundColor = self.config.lineColor; //下划线颜色
    //下划线初始x偏移值
    CGFloat offsetX = self.config.offsetLineX;
    [titleUnderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.config.lineWidth); //line固定宽度
        make.height.mas_equalTo(weakSelf.config.lineHeight); //line固定高度
        make.left.mas_equalTo(offsetX);
        make.bottom.mas_equalTo(0);
    }];
}


#pragma mark ================== 响应 ======================
/// 标题栏label的点击事件
- (void)titleLableClick:(UITapGestureRecognizer *)recognizer {
    WeakSelf
    //上个点击label ->黑色
    self.previousClickedTitleLabel.textColor = self.config.textColor;
    //新点击lebel
    SKTitleLabel *titleLabel = (SKTitleLabel *)recognizer.view;
    titleLabel.textColor = self.config.selectTextColor;
    self.previousClickedTitleLabel = titleLabel; //保存新点击label
    /*********** 红色下划线 ***********/
    //计算下划线偏移,做动画
    CGFloat offsetLineX = titleLabel.sk_x;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.titleUnderline.sk_x = offsetLineX;
        
    } completion:^(BOOL finished) {
    }];
    
    if (self.titleLableBlock) {
        self.titleLableBlock(titleLabel.tag);
    }
    
    
}




@end
