//
//  TopTabControl.h
//  TopTabControl
//
//  Created by vousaimer on 14-12-11.
//  Copyright (c) 2014年 va. All rights reserved.
//


#if __has_feature(objc_arc)
    //compiling with ARC
#else
    #error "this file need compile with arc"
#endif

#import <UIKit/UIKit.h>
#import "TopTabMenuItem.h"
#import "TopTabPage.h"


@class TopTabControl;

/** @brief TopTabControl datasource 需要支持的协议 */
@protocol TopTabControlDataSource<NSObject>

@optional

/**
 *  得到顶部菜单栏的高度
 *
 *  @param tabCtrl tab控件
 *
 *  @return 高度（像素）
 */
- (CGFloat)TopTabHeight:(TopTabControl *)tabCtrl;

/**
 *  得到顶部菜单栏的宽度
 *
 *  @param tabCtrl tab控件
 *
 *  @return 高度（像素）
 */
- (CGFloat)TopTabWidth:(TopTabControl *)tabCtrl;


/**
 *  得到顶部菜单的个数
 *
 *  @param tabCtrl tab控件
 *
 *  @return 返回菜单的个数
 */
- (NSInteger)TopTabMenuCount:(TopTabControl *)tabCtrl;



/**
 *  得到第几个菜单的view
 *
 *  @param tabCtrl tab控件
 *  @param index   菜单的index，从0开始
 *
 *  @return 返回单个菜单项
 */
- (TopTabMenuItem *)TopTabControl:(TopTabControl *)tabCtrl
                      itemAtIndex:(NSUInteger)index;


/**
 *  得到第几个菜单对应的page内容
 *
 *  @param tabCtrl tab控件
 *  @param index   菜单的index，从0开始
 *
 *  @return 返回单个菜单页
 */
- (TopTabPage *)TopTabControl:(TopTabControl *)tabCtrl
                      pageAtIndex:(NSUInteger)index;

@end

@interface TopTabControl : UIView

/** @brief 数据源 */
@property (nonatomic, weak) id<TopTabControlDataSource> datasource;

/** @brief 页码 */
@property (nonatomic, assign, readonly) NSUInteger pageIndex;

/** @brief 是否展示指示器 */
@property (nonatomic, assign) BOOL showIndicatorView;


/**
 *  初始化方法
 *
 *  @param frame 整个控件的大小
 *
 *  @return tab控件
 */
- (instancetype)initWithFrame:(CGRect)frame;



/**
 *  重新刷新数据，类似UItableView的重新刷新数据
 */
- (void)reloadData;


/**
 *  展示第几页，从0开始
 *
 *  @param pageIndex 第几页
 */
- (void)displayPageAtIndex:(NSUInteger)pageIndex;



@end
