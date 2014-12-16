//
//  ViewController.m
//  TopTabControl
//
//  Created by vousaimer on 14-12-11.
//  Copyright (c) 2014年 va. All rights reserved.
//

#import "ViewController.h"
#import "TopTabControlDefine.h"

@interface ViewController ()<TopTabControlDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TopTabControl *tabCtrl = [[TopTabControl alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds
                                                                                                                                      
))];
    tabCtrl.datasource = self;
    [tabCtrl reloadData];
    tabCtrl.showIndicatorView = YES;
    [self.view addSubview:tabCtrl];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TopTabControl Datasource

/**
 *  得到顶部菜单栏的高度
 *
 *  @param tabCtrl tab控件
 *
 *  @return 高度（像素）
 */
- (CGFloat)TopTabHeight:(TopTabControl *)tabCtrl
{
    
    return 30;
}


/**
 *  得到顶部菜单栏的宽度
 *
 *  @param tabCtrl tab控件
 *
 *  @return 高度（像素）
 */
- (CGFloat)TopTabWidth:(TopTabControl *)tabCtrl
{
    return 60;
}


/**
 *  得到顶部菜单的个数
 *
 *  @param tabCtrl tab控件
 *
 *  @return 返回菜单的个数
 */
- (NSInteger)TopTabMenuCount:(TopTabControl *)tabCtrl
{
    return 30;
}



/**
 *  得到第几个菜单的view
 *
 *  @param tabCtrl tab控件
 *  @param index   菜单的index，从0开始
 *
 *  @return 返回单个菜单项
 */
- (TopTabMenuItem *)TopTabControl:(TopTabControl *)tabCtrl
                      itemAtIndex:(NSUInteger)index
{
    TopTabMenuItem *topItem = [[TopTabMenuItem alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    topItem.backgroundColor = [UIColor randomColor];
    UILabel *label = [[UILabel alloc] initWithFrame:topItem.bounds];
    label.text = [NSString stringWithFormat:@"%ld",index];
    label.textAlignment = NSTextAlignmentCenter;
    [topItem addSubview:label];
    return topItem;
}


/**
 *  得到第几个菜单对应的page内容
 *
 *  @param tabCtrl tab控件
 *  @param index   菜单的index，从0开始
 *
 *  @return 返回单个菜单页
 */
- (TopTabPage *)TopTabControl:(TopTabControl *)tabCtrl
                      pageAtIndex:(NSUInteger)index
{
    TopTabPage *page = [[TopTabPage alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.bounds) - 64 - 30
                                                                    )];
    UILabel *label = [[UILabel alloc] initWithFrame:page.bounds];
    label.text = [NSString stringWithFormat:@"%ld",index];
    label.textAlignment = NSTextAlignmentCenter;
    [page addSubview:label];
    
    return page;
}


@end
