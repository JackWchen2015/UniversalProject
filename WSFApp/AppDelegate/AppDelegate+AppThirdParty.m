//
//  AppDelegate+AppThirdParty.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "AppDelegate+AppThirdParty.h"
#import  <IQKeyboardManager/IQKeyboardManager.h>
@implementation AppDelegate (AppThirdParty)


-(void)setupSDKConfig
{
     [self keyboordCoverSetiting];
}

-(void)keyboordCoverSetiting
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
@end
