//
//  SKScrollView.h
//  SKTopSlideTitleBar
//
//  Created by macApple on 2019/12/12.
//  Copyright © 2019 KentSun. All rights reserved.
//
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKScrollView : UIScrollView

///主控制器
@property (nonatomic,weak) UIViewController *viewController;
///子控制器
@property (nonatomic,strong) NSArray *viewControllers;

@end

NS_ASSUME_NONNULL_END
