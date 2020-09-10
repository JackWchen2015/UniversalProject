//
//  LogoutBackView.h
//  Rongxinwang
//
//  Created by 魏海涵 on 2018/1/4.
//  Copyright © 2018年 zhanxianren. All rights reserved.
//

#import "BaseAlertView.h"

@interface LogoutBackView : BaseAlertView

+ (instancetype)logoutAlertView;

+ (LogoutBackView *)alertShowWithOkAction:(OKBlock)ok CancleAction:(CancelBlock)cancle;

@end
