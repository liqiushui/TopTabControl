使用arc，xcode6.1 编译

1、点击菜单自定切换内容页面

2、滑动内容页面菜单自动剧中

3、用户只需要关注菜单的展示和页面的展示就行了

![image](https://github.com/liqiushui/TopTabControl/raw/master/screenshots/screenShot.png)

	Objetive－C

	下面是协议：

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