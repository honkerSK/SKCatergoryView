//
//  SubVC.m
//  SKTopSlideTitleBar
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019年 KentSun. All rights reserved.
//

#import "SubVC.h"


@interface SubVC ()

@end

@implementation SubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self randomColor];
}

- (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}







@end
