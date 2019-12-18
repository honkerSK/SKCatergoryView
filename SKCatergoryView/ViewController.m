//
//  ViewController.m
//  SKCatergoryView
//
//  Created by macApple on 2019/12/18.
//  Copyright © 2019 KentSun. All rights reserved.
//

#import "ViewController.h"

#import "SubVC.h"
#import "SKCatergoryView.h"
#import "SKTitleView.h"
#import "SKScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    NSArray *arrayLists = @[@"关注", @"头条头条头条", @"热点", @"科技", @"游戏游戏", @"数码",@"NBA"];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arrayLists.count];
    for (NSString *titleStr in arrayLists) {
        SubVC *subVc = [[SubVC alloc] init];
        subVc.title = titleStr;
        [arrM addObject:subVc];
    }
    
    //配置对象
    SKCatergoryConfig *config = [[SKCatergoryConfig alloc] init];
    config.titles = arrayLists;
    //    config.titleView = titleView;
    //    config.scrollView = [[SKScrollView alloc] initWithFrame:self.view.bounds];
    config.viewControllers = [NSArray arrayWithArray:arrM];
    config.viewController = self;
    
    config.titleViewMargin = 20;
    config.titleViewHeight = 44;
    config.lineWidth = 20;
    config.lineHeight = 2;
    config.lineColor = [UIColor redColor];
    config.lineY = 44-2;
    //    config.offsetLineX = 10;
    
    SKCatergoryView *catergoryView = [[SKCatergoryView alloc] initWithFrame:CGRectMake(0, SK_StatusBarHeight, nScreenWidth, nScreenHeight-SK_StatusBarHeight) config:config];
    [self.view addSubview:catergoryView];

}


@end
