//
//  AppDelegate+AppService.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "WSFMainTabBarController.h"
#import "WSFLoginViewController.h"
@implementation AppDelegate (AppService)

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void)initService
{
    //注册登录状态监听
       [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(loginStateChange:)
                                                    name:KNotificationLoginStateChange
                                                  object:nil];
}
-(void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
}

-(void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
       
       if (loginSuccess) {//登陆成功加载主窗口控制器
           
           //为避免自动登录成功刷新tabbar
           if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[WSFMainTabBarController class]]) {
               self.mainTabBar = [WSFMainTabBarController new];

               CATransition *anima = [CATransition animation];
               anima.type = @"cube";//设置动画的类型
               anima.subtype = kCATransitionFromRight; //设置动画的方向
               anima.duration = 0.3f;
               
               self.window.rootViewController = self.mainTabBar;
               
               [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
               
           }
           
       }else {//登陆失败加载登陆页面控制器
           
       }
}

//初始化用户系统
-(void)initUserManager
{
    //如果有本地数据，先展示TabBar 随后异步自动登录
    self.mainTabBar = [WSFLoginViewController new];
    self.window.rootViewController = self.mainTabBar;
}

-(void)NetWorkConfig
{
    
}
-(void)monitorNetworkStatus
{
    // 网络监控
    AFNetworkReachabilityManager *networkReachbilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [networkReachbilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
                case AFNetworkReachabilityStatusUnknown:
                DLog(@"GZQ1-未知网络");
                [MBProgressHUD showTopTipMessage:@"未识别网络" isWindow:YES];
                break;
                
                case AFNetworkReachabilityStatusNotReachable:
                DLog(@"GZQ1-断网");
                [MBProgressHUD showTopTipMessage:@"网络跑丢了" isWindow:YES];
                break;
                
                case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"GZQ1-蜂窝数据");
                [MBProgressHUD showTopTipMessage:@"蜂窝数据" isWindow:YES];
                break;
                
                case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"GZQ1-WiFi网络");
                [MBProgressHUD showTopTipMessage:@"WiFi网络" isWindow:YES];
                break;

            default:
                break;
        }
    }];
    
    // 开启监控
    [networkReachbilityManager startMonitoring];
}
-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
