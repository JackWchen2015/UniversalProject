//
//  AppDelegate+AppService.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)

-(void)initService;
//初始化 window
-(void)initWindow;

//初始化用户系统
-(void)initUserManager;

//初始化网络配置
-(void)NetWorkConfig;
//监听网络状态
- (void)monitorNetworkStatus;
//单例
+ (AppDelegate *)shareAppDelegate;
/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
@end

NS_ASSUME_NONNULL_END
