//
//  SKScrollView.m
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//

#import "SKScrollView.h"

@interface SKScrollView()


@end

@implementation SKScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES; //分页
    self.scrollsToTop = NO;
}


- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    for (int i = 0; i < viewControllers.count; i ++) {
        UIViewController *vc = viewControllers[i];
        vc.view.frame = CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        NSAssert(self.viewController != nil, @"没有设置代理控制器！");
        [_viewController addChildViewController:vc];
        [self addSubview:vc.view];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
