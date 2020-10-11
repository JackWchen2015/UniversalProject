//
//  WSFLoginViewController.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFLoginViewController.h"
#import "WSFLoginViewModel.h"
@interface WSFLoginViewController ()
{
   UITextField* accountTxt;
   UIView*  accountBottomLine;
   UITextField* passwordTxt;
   UIView*  passwordBottomLine;
   UIButton* loginBtn;
}
@property(nonatomic,strong)WSFLoginViewModel*  loginVM;
@end

@implementation WSFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
}

-(WSFLoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM=[WSFLoginViewModel new];
    }
    return _loginVM;;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initSubviews
{
    accountTxt=[UITextField new];
    accountTxt.delegate=self;
    accountTxt.placeholder=NSLocalizedString(@"Input Email Account", nil);
    [self.view addSubview:accountTxt];
    [accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).offset(SY(150));
        make.left.mas_equalTo(self.view).offset(SX(50));
        make.right.mas_equalTo(self.view).offset(SX(-50));
        make.height.mas_equalTo(SY(45));
    }];
    
    accountBottomLine=[UIView new];
    accountBottomLine.backgroundColor=CNavBgColor;
    [self.view addSubview:accountBottomLine];
    [accountBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountTxt.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(accountTxt);
        make.width.mas_equalTo(accountTxt);
    }];
    
    UIButton* accessory=[UIButton buttonWithType:UIButtonTypeCustom];
    [accessory setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
    [accessory setImage:[UIImage imageNamed:@"icon_show"] forState:UIControlStateSelected];
    [accessory addTarget:self action:@selector(accesorySecureFun:) forControlEvents:UIControlEventTouchUpInside];
    accessory.width=SX(34);
    accessory.height=SY(23);
    
    passwordTxt=[UITextField new];
    passwordTxt.secureTextEntry=YES;
    passwordTxt.delegate=self;
    passwordTxt.rightView=accessory;
    passwordTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTxt.rightViewMode=UITextFieldViewModeUnlessEditing;
    passwordTxt.placeholder=NSLocalizedString(@"Input Password Range 6 to 20", nil);
    [self.view addSubview:passwordTxt];
    [passwordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountBottomLine.mas_bottom).offset(SY(60));
        make.left.mas_equalTo(self.view).offset(SX(50));
        make.right.mas_equalTo(self.view).offset(SX(-50));
        make.height.mas_equalTo(SY(45));
    }];
    
    passwordBottomLine=[UIView new];
    passwordBottomLine.backgroundColor=CNavBgColor;
    [self.view addSubview:passwordBottomLine];
    [passwordBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordTxt.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(passwordTxt);
        make.width.mas_equalTo(passwordTxt);
    }];
    
    loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=SX(4);
    loginBtn.layer.masksToBounds=YES;
    loginBtn.titleLabel.font=SYSTEMFONT(15);
    [loginBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SX(280));
        make.bottom.mas_equalTo(self.view).offset(SY(-100));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(SY(40));
    }];
}
-(void)addConstraint
{
    [super addConstraint];
}
-(void)setupRAC
{
    RAC(self.loginVM,emailStr)=[RACSignal merge:@[accountTxt.rac_textSignal,RACObserve(accountTxt, text)]];
    RAC(self.loginVM,pwdStr)=[RACSignal merge:@[passwordTxt.rac_textSignal,RACObserve(passwordTxt, text)]];
    
    RAC(loginBtn,enabled)=RACObserve(self.loginVM, submitable);
       @weakify(self);
       [[[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
           @strongify(self);
           [self->loginBtn startLoadingAnimation];
       }]subscribeNext:^(id x) {
           if (true) {
               @strongify(self);
//               [self.loginVM.networkingRAC.requestCommand execute:nil];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self->loginBtn stopLoadingAnimation];
                    KPostNotification(KNotificationLoginStateChange, @YES);
               });

           }
           else
           {
              
           }
       }];
//       [[self.loginVM.networkingRAC.requestCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
//           @strongify(self);
//           if (x.boolValue) {
//               [self->loginBtn startLoadingAnimation];
//               self->loginBtn.enabled =NO;
//           } else {
//               [self->loginBtn stopLoadingAnimation];
//               self->loginBtn.enabled=YES;
//           }
//       }];
//       [self.loginVM.networkingRAC.requestErrorSignal
//        subscribeNext:^(NSError *error) {
//            @strongify(self);
//           [MBProgressHUD showErrorMessage:error.localizedDescription];
//        }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==accountTxt)
    {
        accountBottomLine.backgroundColor=CNavBgColor;
    }
    if(textField==passwordTxt)
    {
        passwordBottomLine.backgroundColor=CNavBgColor;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==accountTxt)
    {
        accountBottomLine.backgroundColor=CViewBgColor;
    }
    if(textField==passwordTxt)
    {
        passwordBottomLine.backgroundColor=CViewBgColor;
    }
}
@end
