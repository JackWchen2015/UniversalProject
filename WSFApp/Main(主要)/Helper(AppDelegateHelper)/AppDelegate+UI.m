//
//  AppDelegate+UI.m
//  WSFApp
//
//  Created by USER on 2020/9/7.
//  Copyright © 2020 USER. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "MainHelper.h"
#import "AvoidCrash.h"
#import "HomePageVC.h"
#import "BasicMainNC.h"
#import "BasicMainTBVC.h"
@implementation AppDelegate (UI)

-(void)setMyWindowAndRootViewController
{
    [self setItems];
    [self setViews];
}
-(void)setItems
{
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:WhiteColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSForegroundColorAttributeName:kMainFontColor};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:kMainFontColor];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
}
-(void)setViews
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[BasicMainTBVC alloc]init];
}



@end
