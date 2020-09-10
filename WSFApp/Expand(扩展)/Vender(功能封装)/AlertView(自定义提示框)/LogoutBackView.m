//
//  LogoutBackView.m
//  Rongxinwang
//
//  Created by 魏海涵 on 2018/1/4.
//  Copyright © 2018年 zhanxianren. All rights reserved.
//

#import "LogoutBackView.h"

@implementation LogoutBackView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)logoutAlertView {
    NSArray *xibs;
    if ([xibs firstObject] == nil) {
        xibs = [[NSBundle mainBundle] loadNibNamed:@"LogoutBackView" owner:self options:nil];
    }
    return (LogoutBackView *)[xibs firstObject];
}

+ (LogoutBackView *)alertShowWithOkAction:(OKBlock)ok CancleAction:(CancelBlock)cancle {
    LogoutBackView *alert = [LogoutBackView logoutAlertView];
    alert.okBlock = ok;
    alert.cancelBlock = cancle;
    [alert show];
    return alert;
}

@end
