//
//  TopTabControl.m
//  TopTabControl
//
//  Created by vousaimer on 14-12-11.
//  Copyright (c) 2014年 va. All rights reserved.
//

#import "TopTabControl.h"
#import "TopTabControlDefine.h"
#import "UIColor+RandomColor.h"

@interface TopTabControl()<UITableViewDataSource,UITableViewDelegate>

/** @brief 顶部菜单栏横向滑动的table */
@property (nonatomic, strong) UITableView *topMenuTableView;

/** @brief 菜单下面横向滑动内容的table */
@property (nonatomic, strong) UITableView *contentTableView;

/** @brief 指示器view */
@property (nonatomic, strong) UIView *indicatorView;

@end


@implementation TopTabControl

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
}


- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(handleEndScroll)
                                               object:nil];
}

#pragma mark - UIKIT




#pragma mark - override

- (UITableView *)topMenuTableView
{
    if(nil == _topMenuTableView)
    {
        CGFloat topMenuHeight = TopTabControl_Default_TopMenuHeight;
        if([self.datasource respondsToSelector:@selector(TopTabHeight:)])
        {
            topMenuHeight = [self.datasource TopTabHeight:self];
        }
        
        //before rotate bounds = (0, 0, width, height)  , rototate -90 bounds = (0, 0, height, width)
        CGFloat x = CGRectGetWidth(self.frame)/2 - topMenuHeight/2;
        CGFloat y = -CGRectGetWidth(self.frame)/2 + topMenuHeight/2;
        CGRect topMenuRect = CGRectMake(x, y, topMenuHeight, CGRectGetWidth(self.frame));
        _topMenuTableView = [[UITableView alloc] initWithFrame:topMenuRect
                                                         style:UITableViewStylePlain];
        [self addSubview:_topMenuTableView];
        _topMenuTableView.backgroundColor = [UIColor randomColor];
        _topMenuTableView.dataSource = self;
        _topMenuTableView.delegate = self;
        _topMenuTableView.showsVerticalScrollIndicator = NO;
        _topMenuTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        
    }
    return _topMenuTableView;
}


- (UITableView *)contentTableView
{
    if(nil == _contentTableView)
    {
        CGFloat contentHeight = CGRectGetWidth(self.frame);
        CGFloat contentWidth  = CGRectGetHeight(self.frame) - [self getMenuHeight];
        CGFloat x = CGRectGetWidth(self.frame)/2 - contentWidth/2;
        CGFloat y = (CGRectGetHeight(self.frame) - [self getMenuHeight])/2 - contentHeight/2 + ([self getMenuHeight]);
        CGRect contentRect = CGRectMake(x, y, contentWidth, contentHeight);
        _contentTableView = [[UITableView alloc] initWithFrame:contentRect
                                                         style:UITableViewStylePlain];
        [self addSubview:_contentTableView];
        
        _contentTableView.backgroundColor = [UIColor randomColor];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.pagingEnabled = YES;
        _contentTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    }
    
    return _contentTableView;
}

- (UIView *)indicatorView
{
    if(nil == _indicatorView)
    {
        CGFloat indicatorHeight = [self getMenuWidth];
        CGFloat indicatorWidth  = TopTabControl_Default_IndicatorWidth;
        CGFloat x = 0;
        CGFloat y = 0;
        CGRect  indicatorRect = CGRectMake(x, y, indicatorWidth, indicatorHeight);
        _indicatorView = [[UIView alloc] initWithFrame:indicatorRect];
        _indicatorView.backgroundColor = [UIColor yellowColor];
        [self.topMenuTableView addSubview:_indicatorView];
        [self.topMenuTableView bringSubviewToFront:_indicatorView];
    }
    return _indicatorView;
}




#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if([self.datasource respondsToSelector:@selector(TopTabMenuCount:)])
    {
        return [self.datasource TopTabMenuCount:self];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.topMenuTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopMenuCell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"TopMenuCell"];
            cell.frame = CGRectMake(0,
                                    0,
                                    [self getMenuHeight],
                                    [self getMenuWidth]);
        }
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)
                                                     withObject:nil];
        if([self.datasource respondsToSelector:@selector(TopTabControl:itemAtIndex:)])
        {
            TopTabMenuItem *item = [self.datasource TopTabControl:self
                                                      itemAtIndex:indexPath.row];
            cell.contentView.backgroundColor = [UIColor randomColor];
            [cell.contentView addSubview:item];
            CGFloat x = ([self getMenuHeight]- CGRectGetWidth(item.frame))/2;
            CGFloat y = ([self getMenuWidth] - CGRectGetHeight(item.frame))/2;
            item.frame = CGRectMake(x,
                                     y,
                                    CGRectGetWidth(item.frame),
                                    CGRectGetHeight(item.frame));
            item.transform = CGAffineTransformMakeRotation(M_PI / 2);
            return cell;
        }
        
    }
    
    if(tableView == _contentTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentPageCell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"ContentPageCell"];
            cell.frame = CGRectMake(0,
                                    0,
                                    CGRectGetHeight(self.frame) - [self getMenuHeight],
                                    CGRectGetWidth(self.frame));
        }
        [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)
                                                     withObject:nil];
        if([self.datasource respondsToSelector:@selector(TopTabControl:itemAtIndex:)])
        {
            TopTabPage *page = [self.datasource TopTabControl:self
                                                              pageAtIndex:indexPath.row];
            cell.contentView.backgroundColor = [UIColor randomColor];
            [cell.contentView addSubview:page];
            CGFloat x = (CGRectGetWidth(cell.frame) - CGRectGetWidth(page.frame))/2;
            CGFloat y = (CGRectGetHeight(cell.frame) - CGRectGetHeight(page.frame))/2;
            page.frame = CGRectMake(x,
                                    y,
                                    CGRectGetWidth(page.frame),
                                    CGRectGetHeight(page.frame));
            page.transform = CGAffineTransformMakeRotation(M_PI / 2);
         }
        return cell;
        
    }
 
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.topMenuTableView)
    {
        return [self getMenuWidth];
    }
    
    if (tableView == self.contentTableView) {
        return CGRectGetWidth(self.frame);
    }
    return 0;
}



#pragma mark - UItableView Delegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.contentTableView)
    {
        NSUInteger tempPage = (self.contentTableView.contentOffset.y + 0.5*CGRectGetWidth(self.frame))/CGRectGetWidth(self.frame);
        if(tempPage != self.pageIndex)
            _pageIndex = tempPage;
        [self updateIndicatorPosition];
    }
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.contentTableView)
    {
        [self handleEndScroll];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView == self.contentTableView)
    {
        if(!decelerate)
        {
            [self handleEndScroll];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.topMenuTableView)
    {
        [self contentTablesSrollToIndexPath:indexPath];
    }
}

#pragma mark - public method

- (void)reloadData
{
    [self.topMenuTableView reloadData];
    [self.contentTableView reloadData];
}


- (void)setShowIndicatorView:(BOOL)showIndicatorView
{
    _showIndicatorView = showIndicatorView;
    if(showIndicatorView)
    {
        [[self indicatorView] setHidden:NO];;
        [self.topMenuTableView bringSubviewToFront:[self indicatorView]];
    }
    else
    {
        [[self indicatorView] setHidden:YES];
    }
    
}


- (void)displayPageAtIndex:(NSUInteger)pageIndex
{
    [self contentTablesSrollToIndexPath:[NSIndexPath indexPathForRow:pageIndex inSection:0]];
}

#pragma mark - private method

/**
 *  得到顶部菜单栏的高度
 *
 *  @return 高度
 */
- (CGFloat)getMenuHeight
{
    
    if([self.datasource respondsToSelector:@selector(TopTabHeight:)])
    {
        return [self.datasource TopTabHeight:self];
    }
    return 30;
}

/**
 *  得到顶部菜单栏单个菜单的宽度
 *
 *  @return 宽度
 */
- (CGFloat)getMenuWidth
{
    
    if([self.datasource respondsToSelector:@selector(TopTabWidth:)])
    {
        return [self.datasource TopTabWidth:self];
    }
    return 60;
}

/**
 *  刷新指示器的位置
 */
- (void)updateIndicatorPosition
{
    if(self.showIndicatorView)
    {
        CGFloat y = self.contentTableView.contentOffset.y / self.contentTableView.contentSize.height;
        self.indicatorView.frame = CGRectMake(self.indicatorView.frame.origin.x,
                                              (y * self.topMenuTableView.contentSize.height),
                                              self.indicatorView.frame.size.width,
                                              self.indicatorView.frame.size.height);
    }
}


/**
 *  page table 停止滚动的时候
 */
- (void)handleEndScroll
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pageIndex inSection:0];
    [self.topMenuTableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:UITableViewScrollPositionMiddle
                                         animated:YES];
}


/**
 *  <#Description#>
 *
 *  @param indexPath <#indexPath description#>
 */
- (void)contentTablesSrollToIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row >= max)
//    {
//
//    }
    [self.contentTableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:UITableViewScrollPositionMiddle
                                         animated:NO];
    [self performSelector:@selector(handleEndScroll) withObject:nil afterDelay:0.25];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
