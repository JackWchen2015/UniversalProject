//
//  WSFHomeMainPageViewController.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFDemoViewController.h"
#import "WSFBaseWebViewController.h"
#import "UIViewController+WSFAlertAndActionSheet.h"
#import "WSFCustiomPopView.h"
@interface WSFDemoViewController ()

@end

@implementation WSFDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"Demo";
    [self addNavigationItemWithTitles
     :@[@"加载"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
}

-(void)initSubviews
{

    
    UIButton* PushBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [PushBtn setTitle:NSLocalizedString(@"Push", nil) forState:UIControlStateNormal];
    PushBtn.layer.cornerRadius=SX(4);
    PushBtn.layer.masksToBounds=YES;
    PushBtn.titleLabel.font=SYSTEMFONT(15);
    [PushBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [PushBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:PushBtn];
    [PushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-80);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[PushBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController pushViewController:[WSFBaseViewController new] animated:YES];
    }];
    
    UIButton* uDeskBtn=[UIButton buttonWithType:UIButtonTypeCustom];
       [uDeskBtn setTitle:NSLocalizedString(@"Udesk", nil) forState:UIControlStateNormal];
       ViewRadius(uDeskBtn,SX(4));
       uDeskBtn.titleLabel.font=SYSTEMFONT(15);
       [uDeskBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
       [uDeskBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
       [self.view addSubview:uDeskBtn];
       [uDeskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(SX(280));
           make.bottom.mas_equalTo(PushBtn.mas_top).offset(-20);
           make.centerX.mas_equalTo(self.view);
           make.height.mas_equalTo(SY(40));
       }];
       
       [[uDeskBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [MBProgressHUD showTopTipMessage:@"开发中" isWindow:YES];
//           UdeskSDKManager *sdkManager = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle] sdkConfig:[UdeskSDKConfig customConfig]];
//           [sdkManager presentUdeskInViewController:self completion:nil];
//           [sdkManager pushUdeskInViewController:self.navigationController completion:nil];
//           [self.navigationController pushViewController:[WSFBaseViewController new] animated:YES];
       }];
    
    UIButton* popBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [popBtn setTitle:NSLocalizedString(@"CustomPop", nil) forState:UIControlStateNormal];
    popBtn.layer.cornerRadius=SX(4);
    popBtn.layer.masksToBounds=YES;
    popBtn.titleLabel.font=SYSTEMFONT(15);
    [popBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [popBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.bottom.mas_equalTo(uDeskBtn.mas_top).offset(-20);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[popBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        WSFCustiomPopView* popView=[[WSFCustiomPopView alloc] initWithFrame:[UIScreen mainScreen].bounds content:@"平台已检测到您存在多次虚假审核，请谨慎操作，如您拒绝后，师傅发起的申诉被判成立，可能会限制您使用好评返现的功能"];
        [kAppWindow addSubview:popView];
        [popView show];
    }];
    
    UIButton* psntBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [psntBtn setTitle:NSLocalizedString(@"Present", nil) forState:UIControlStateNormal];
    psntBtn.layer.cornerRadius=SX(4);
    psntBtn.layer.masksToBounds=YES;
    psntBtn.titleLabel.font=SYSTEMFONT(15);
    [psntBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [psntBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:psntBtn];
    [psntBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.top.mas_equalTo(PushBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[psntBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        WSFBaseWebViewController *webView = [[WSFBaseWebViewController alloc] initWithUrl:@"http://hao123.com"];
        webView.isShowCloseBtn = YES;
        WSFBaseNavigationController *loginNavi =[[WSFBaseNavigationController alloc] initWithRootViewController:webView];
        [self presentViewController:loginNavi animated:YES completion:nil];
      }];
    
    UIButton* showDotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [showDotBtn setTitle:NSLocalizedString(@"Show Dot", nil) forState:UIControlStateNormal];
    showDotBtn.layer.cornerRadius=SX(4);
    showDotBtn.layer.masksToBounds=YES;
    showDotBtn.titleLabel.font=SYSTEMFONT(15);
    [showDotBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [showDotBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:showDotBtn];
    [showDotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(psntBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[showDotBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [kAppDelegate.mainTabBar setRedDotWithIndex:3 isShow:YES];
    }];
    
    UIButton* AlertBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [AlertBtn setTitle:NSLocalizedString(@"Alert", nil) forState:UIControlStateNormal];
    AlertBtn.layer.cornerRadius=SX(4);
    AlertBtn.layer.masksToBounds=YES;
    AlertBtn.titleLabel.font=SYSTEMFONT(15);
    [AlertBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [AlertBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:AlertBtn];
    [AlertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.top.mas_equalTo(showDotBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[AlertBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self alertView];
    }];
    
    
    UIButton* ActionSheetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [ActionSheetBtn setTitle:NSLocalizedString(@"ActionSheet", nil) forState:UIControlStateNormal];
    ActionSheetBtn.layer.cornerRadius=SX(4);
    ActionSheetBtn.layer.masksToBounds=YES;
    ActionSheetBtn.titleLabel.font=SYSTEMFONT(15);
    [ActionSheetBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [ActionSheetBtn setBackgroundImage:[UIImage imageWithColor:kRandomColor] forState:UIControlStateNormal];
    [self.view addSubview:ActionSheetBtn];
    [ActionSheetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.top.mas_equalTo(AlertBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
    
    [[ActionSheetBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self actionSheet];
    }];
    
}

#pragma mark -  alertview
-(void)alertView{
    [self AlertWithTitle:@"测试标题" message:@"测试内容" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
        DLog(@"点击了 %ld",index);
    }];
}

#pragma mark -  ActionSheet
-(void)actionSheet{
    [self ActionSheetWithTitle:@"测试" message:@"测试内容" destructive:nil destructiveAction:nil andOthers:@[@"1",@"2",@"3",@"4"] animated:YES action:^(NSInteger index) {
        DLog(@"点了 %ld",index);
    }];
}

-(void)naviBtnClick:(UIButton*)btn
{
    [self showLoading];
}

-(void)showLoading
{
    [self showRefreshingViewWithTip:@"loading..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenRefreshingView];
    });
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
