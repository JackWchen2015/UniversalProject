//
//  WSFBaseWebViewController.m
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseWebViewController.h"

@interface WSFBaseWebViewController ()<WKNavigationDelegate>

@property (nonatomic,assign) double lastProgress;//上次进度条位置

@end

@implementation WSFBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)updateNavigationItems{
    if (_isShowCloseBtn) {
        if (self.webView.canGoBack) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
            [self addNavigationItemWithImageNames:@[@"back_icon",@"close_icon"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2000,@2001]];
            
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            
            //iOS8系统下发现的问题：在导航栏侧滑过程中，执行添加导航栏按钮操作，会出现按钮重复，导致导航栏一系列错乱问题
            //解决方案待尝试：每个vc显示时，遍历 self.navigationController.navigationBar.subviews 根据tag去重
            //现在先把iOS 9以下的不使用动态添加按钮 其实微信也是这样做的，即便返回到webview的第一页也保留了关闭按钮
            
            if (IOS9_OR_LATER) {
                //            [self addNavigationItemWithTitles:@[@"返回"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2001]];
                [self addNavigationItemWithImageNames:@[@"back_icon"] isLeft:YES target:self action:@selector(leftBtnClick:) tags:@[@2001]];
            }
        }
    }
}

-(void)leftBtnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 2000:
            [super backBtnClicked];
            
            break;
        case 2001:
        {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            
            break;
        default:
            break;
    }
}

-(void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
