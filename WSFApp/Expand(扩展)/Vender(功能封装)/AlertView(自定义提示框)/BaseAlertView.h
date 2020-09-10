//
//  BaseAlertView.h
//  Rongxinloan
//
//  Created by 魏海涵 on 2017/12/12.
//  Copyright © 2017年 zhanxianren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OKBlock) (void);
typedef void (^ClickButtonAtIndex) (NSUInteger index);
typedef void (^CancelBlock) (void);

@interface BaseAlertView : UIView

@property (copy, nonatomic) CancelBlock cancelBlock;
@property (copy, nonatomic) OKBlock okBlock;

/**
 默认使用Button tag 做为index,cancel button不调用此方法
 */
@property (copy, nonatomic) ClickButtonAtIndex clickButtonAtIndexBlock;


+ (void)dismissAllAlertView;
+ (void)dismissAlertViewInView:(UIView *)view;

- (void)show;

- (void)dismissAlertView;

- (void)showInView:(UIView *)view;


/**
 需要该弹窗一直显示时重写此方法，返回YES，默认返回NO
 
 @return bool value
 */
- (BOOL)alwaysShowAlertView;


/**
 确定方法，会调用okBlock
 
 @param button 确定按钮
 */
- (IBAction)okAction:(UIButton *)button;

/**
 取消方法，会调用 cancelBlock
 
 @param button 取消按钮
 
 */
- (IBAction)cancelAction:(UIButton *)button;


/**
 按钮点击方法，会调用
 
 @param button clickButtonAtIndex
 */
- (IBAction)clickButton:(UIButton *)button;

@end
