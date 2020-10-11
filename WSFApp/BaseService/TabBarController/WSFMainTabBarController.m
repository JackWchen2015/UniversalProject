//
//  WSFMainTabBarViewController.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFMainTabBarController.h"
#import "WSFBaseViewController.h"
#import "WSFBaseNavigationController.h"
#import "UITabBar+WSFCustomBadge.h"
#import "WSFTabBar.h"
#import "WSFDemoViewController.h"
@interface WSFMainTabBarController ()
@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC
@end

@implementation WSFMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[WSFTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}
#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
//  HomeViewController *homeVC = [[HomeViewController alloc]init];
//  WaterFallListViewController *homeVC = [WaterFallListViewController new];
    WSFBaseViewController *makeFriendVC = [[WSFBaseViewController alloc]init];
    [self setupChildViewController:makeFriendVC title:@"首页" imageName:@"icon_tabbar_homepage" seleceImageName:@"icon_tabbar_homepage_selected"];
    
//    MakeFriendsViewController *makeFriendVC = [[MakeFriendsViewController alloc]init];
    WSFDemoViewController *homeVC = [[WSFDemoViewController alloc]init];
    [self setupChildViewController:homeVC title:@"Demo" imageName:@"icon_tabbar_onsite" seleceImageName:@"icon_tabbar_onsite_selected"];
    
//    MsgViewController *msgVC = [[MsgViewController alloc]init];
    WSFBaseViewController *msgVC = [WSFBaseViewController new];
    [self setupChildViewController:msgVC title:@"消息" imageName:@"icon_tabbar_merchant_normal" seleceImageName:@"icon_tabbar_merchant_selected"];
    
    
    WSFBaseViewController *mineVC = [[WSFBaseViewController alloc]init];
    [self setupChildViewController:mineVC title:@"我的" imageName:@"icon_tabbar_mine" seleceImageName:@"icon_tabbar_mine_selected"];
    
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    WSFBaseNavigationController *nav = [[WSFBaseNavigationController alloc]initWithRootViewController:controller];
    
//    [self addChildViewController:nav];
    [_VCS addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
    
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
