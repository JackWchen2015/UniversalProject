//
//  BaseAlertView.m
//  Rongxinloan
//
//  Created by 魏海涵 on 2017/12/12.
//  Copyright © 2017年 zhanxianren. All rights reserved.
//

#import "BaseAlertView.h"
#import <MBProgressHUD.h>

@interface BaseAlertView ()
@property (weak, nonatomic) UIView *showInThisView;
@end

@implementation BaseAlertView
- (instancetype)init {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

#pragma mark - PublicMethod

+ (void)dismissAllAlertView {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        // 遍历查找MBProgressHUD,查找到MBProgressHUD隐藏,并退出
        MBProgressHUD *hud = [MBProgressHUD HUDForView:window];
        UIView *view = hud.subviews.lastObject;
        if ([view isKindOfClass:[BaseAlertView class]]) {
            BOOL showAlways = [view performSelector:@selector(alwaysShowAlertView)];
            if (showAlways) {
                continue;
            }
        }
        if ([MBProgressHUD hideHUDForView:window animated:YES]) {
            return;
        }
    }
}

+ (void)dismissAlertViewInView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)show{
    [BaseAlertView dismissAllAlertView];
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view{
    [BaseAlertView dismissAllAlertView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.showInThisView = view;

//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.6f];
    // 隐藏中间进度指示器
//    hud.bezelView.hidden = YES;
    [hud addSubview:self];
    self.frame = hud.bounds;
    
    
    self.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
}

- (BOOL)alwaysShowAlertView{
    return NO;
}

- (void)dismissAlertView{
    [MBProgressHUD hideHUDForView:self.showInThisView animated:YES];
}

- (IBAction)okAction:(UIButton *)sender{
    if (self.okBlock) {
        self.okBlock();
    }
    [self dismissAlertView];
}

- (IBAction)cancelAction:(UIButton *)button{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissAlertView];
}

- (IBAction)clickButton:(UIButton *)button{
    NSInteger index = button.tag;
    if (self.clickButtonAtIndexBlock) {
        self.clickButtonAtIndexBlock(index);
    }
    [self dismissAlertView];
}

@end
