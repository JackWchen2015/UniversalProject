//
//  BasicWebVC.m
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import "BasicWebVC.h"
#import "BasicWebView.h"

@interface BasicWebVC ()<WKNavigationDelegate>

@property(nonatomic,strong)BasicWebView *webParentView;

@end

@implementation BasicWebVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!CGRectIsEmpty(self.viewFrame)) self.view.frame = self.viewFrame;
}

- (void)reloadForGetWebView:(NSString *)htmlStr
{
    htmlStr = [NSString stringWithFormat:@"%@%@",_Environment_Domain,htmlStr];
    [self.webParentView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlStr]]];
}

- (void)reloadForPostWebView:(NSString *)htmlStr parameters:(NSDictionary *)parameters
{
    htmlStr = [NSString stringWithFormat:@"%@%@",_Environment_Domain,htmlStr];
    NSMutableURLRequest * requestShare = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:htmlStr]];
    [requestShare addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestShare setHTTPMethod:@"POST"];
    [requestShare setHTTPBody: [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]];
    [self.webParentView.webView loadRequest:requestShare];
}
#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidStartLoad"
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //"webViewDidFinishLoad"
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidFailLoad"
    [ProgressHUD showProgressHUDInView:UI_Window withText:Request_Failure afterDelay:HUD_DismisTime];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //"webViewWillLoadData"
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //"webViewWillAuthentication"
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling , nil);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
#pragma mark - call tel:
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        [AppUtility callWithPhoneNumber:resourceSpecifier];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - lazy
-(BasicWebView *)webParentView
{
    if (!_webParentView) {
        
        _webParentView = [[BasicWebView alloc] initWithFrame:self.view.bounds canCopy:YES canZoom:NO];
        _webParentView.webView.navigationDelegate = self;
        [self.view addSubview:self.webParentView];
    }
    return _webParentView;
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
