//
//  SKCatergoryView.m
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//

#import "SKCatergoryView.h"

#import "UIView+SKFrame.h"
#import "SKTitleView.h"
#import "SKScrollView.h"
#import "SKTitleLabel.h"

@interface SKCatergoryView()<UIScrollViewDelegate>
{
    CGFloat _y; //scrollView 的y值
}

@property (nonatomic ,weak) SKTitleView *titleView; // 标题栏scrollView
@property (nonatomic, weak) SKScrollView *scrollView; //底部scrollView
@property (nonatomic, strong) SKCatergoryConfig *config;

/// 首页第一个控制器
@property(nonatomic, strong) UIViewController *needScrollToTopPage;
/// 记录当前是第几个控制器
@property (nonatomic, assign) NSUInteger index;

@end

@implementation SKCatergoryView

- (instancetype)initWithFrame:(CGRect)frame config:(SKCatergoryConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self initConfig];
        [self createView];
    }
    return self;
}

//默认配置
- (void)initConfig{
    self.config.titleViewWidth =  self.config.titleViewWidth?:nScreenWidth;
    self.config.titleViewHeight = self.config.titleViewHeight ?:44;
    self.config.titleViewMargin = self.config.titleViewMargin ?:20;
    self.config.titleViewBackgroudColor = self.config.titleViewBackgroudColor ?:[UIColor whiteColor];
    self.config.textColor = self.config.textColor ?: [UIColor blackColor];
    self.config.selectTextColor = self.config.selectTextColor ?: [UIColor redColor];
    self.config.titleViewFont = self.config.titleViewFont ?: [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.config.lineWidth = self.config.lineWidth?:20;
    self.config.lineHeight = self.config.lineHeight?:2;
    self.config.lineColor = self.config.lineColor ?: [UIColor redColor];
    self.config.lineY = self.config.lineY ?: (self.config.titleViewHeight - self.config.lineHeight);
    self.config.offsetLineX = self.config.offsetLineX?:0;
}

- (void)createView{
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor whiteColor];
    
    //1.水平方向滚动视图UIScrollView
    SKTitleView *titleView = [[SKTitleView alloc] initWithFrame:CGRectMake(16, 0, nScreenWidth - 16*2, self.config.titleViewHeight) config:self.config];
    [self addSubview:titleView];
    self.titleView = titleView;
    
    // 添加scrollView添加到父视图，并设置其约束
    //[self.view addSubview:smallView];
//    self.navigationItem.titleView = smallView;
    
//    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(16); //左右边距默认16
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(44);
//    }];
    
    // 不计算内边距
    if (@available(iOS 11.0, *)) {
        self.titleView.contentInsetAdjustmentBehavior = NO;
    }else{
        // Fallback on earlier versions
        self.config.viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.titleView.titleLableBlock = ^(NSInteger tag) {
        //计算偏移量, 做动画
        CGFloat offsetX = tag * weakSelf.scrollView.frame.size.width;
        CGFloat offsetY = weakSelf.scrollView.contentOffset.y;
        CGPoint offset = CGPointMake(offsetX, offsetY);
        [weakSelf.scrollView setContentOffset:offset animated:YES];
    };
    
    //2.底部子控制器scrollView
    _y = CGRectGetHeight(self.titleView.frame);
    SKScrollView *scrollView = [[SKScrollView alloc] init];
    [self addSubview:scrollView];
    scrollView.frame = CGRectMake(0, _y, nScreenWidth, self.sk_height - 44);
    
    self.scrollView = scrollView;
    scrollView.delegate = self;
    
    scrollView.viewController = self.config.viewController;
    scrollView.viewControllers = self.config.viewControllers;
    
}

#pragma mark - ScrollToTop
// 始终只有一个子控制 tableView.scrollsToTop 为YES
- (void)setScrollToTopWithTableViewIndex:(NSInteger)index {
    //主控制器
    UIViewController *mainVC = self.config.viewController;
    self.needScrollToTopPage = mainVC.childViewControllers[index]; //当前控制器
}
#pragma mark ================== scrollView代理方法 ======================
/// bigscrollView 水平滚动结束后调用（代码导致）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.scrollView.frame.size.width;
    //记录当前index
    self.index = index;
    
    // 滚动标题栏
    NSArray *subviewsArr = [self.titleView getSubviews];
    SKTitleLabel *titleLable = (SKTitleLabel *)subviewsArr[index];
    CGFloat offsetx = titleLable.center.x - self.titleView.frame.size.width * 0.5;
    CGFloat offsetMax = self.titleView.contentSize.width - self.titleView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.titleView.contentOffset.y);
    [self.titleView setContentOffset:offset animated:YES];
    
    /*********** 红色下划线 ***********/
    //计算下划线偏移,做动画
    CGFloat offsetLineX = titleLable.sk_x + self.config.offsetLineX;
    [self.titleView setTitleUnderlineWitOffsetLineX:offsetLineX];
    
    // 添加控制器
    UIViewController *mainVC = self.config.viewController;
    UIViewController *newsVc = mainVC.childViewControllers[index];
    //newsVc.index = index;
    WeakSelf;
    [self.titleView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            NSArray *subviewsArr = [weakSelf.titleView getSubviews];
            SKTitleLabel *temlabel = subviewsArr[idx];
//            temlabel.scale = 0.1;
            temlabel.textColor = weakSelf.config.textColor;
        }
    }];
    
    [self setScrollToTopWithTableViewIndex:index];
    
    if (newsVc.view.superview) return;
    newsVc.view.frame = scrollView.bounds;
    [self.scrollView addSubview:newsVc.view];
    
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在bigscrollView 水平滚动 (放大效果)*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    
    NSArray *subviewsArr = [self.titleView getSubviews];
    SKTitleLabel *labelLeft = subviewsArr[leftIndex];
    //标题栏颜色渐变并放大效果, 往左边走
    labelLeft.scale = scaleLeft;
    
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < subviewsArr.count) {
        //标题栏 往右边走
        SKTitleLabel *labelRight = subviewsArr[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //    _scroller.titles = self.titles;
    _scrollView.contentSize = CGSizeMake(self.config.titles.count * nScreenWidth, _y);
    
}
-(void)dealloc{
    
    NSLog(@"%s",__func__);
}

@end
