//
//  WSFBaseViewController.h
//  WSFApp
//
//  Created by jack on 2020/9/11.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFBaseNavigationController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WSFBaseViewController : UIViewController
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

@property(nonatomic)UIInterfaceOrientationMask supportedOrientationMask;

@property (nonatomic) UITableView * tableView;
@property (nonatomic) UICollectionView * collectionView;

-(void)didInitialized  NS_REQUIRES_SUPER;

#pragma mark --  加载 ViewController
//是否为刷新状态
- (BOOL)isShowRefreshingStatus;
//显示菊花
- (void)showRefreshingViewWithTip:(NSString *)tip;
//关闭菊花
- (void)hiddenRefreshingView;
//显示错误
- (void)showErrorViewWithTip:(NSString *)tip;

#pragma mark - 无数据显示
/**
 *  显示没有数据页面
 */
-(void)showNoDataView;

/**
 *  移除无数据页面
 */
-(void)removeNoDataView;


#pragma  mark -  导航栏

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLeftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 导航栏添加文本按钮

 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮

 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;




@end


@interface WSFBaseViewController (WSFSubclassViewController)

- (void)initSubviews NS_REQUIRES_SUPER;
-(void)addConstraint;
-(void)setupRAC;
@end
NS_ASSUME_NONNULL_END
