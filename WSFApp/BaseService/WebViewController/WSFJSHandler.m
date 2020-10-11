//
//  WSFJSHandle.m
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFJSHandler.h"

@implementation WSFJSHandler
-(instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration {
    self = [super init];
    if (self) {
        _webVC = webVC;
        _configuration = configuration;
        //js handler
        //注册JS 事件
        [configuration.userContentController addScriptMessageHandler:self name:@"backPage"];
    }
    return self;
}

#pragma mark -  JS 调用 Native  代理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"backPage"]) {
        //返回
        if (self.webVC.presentingViewController) {
            [self.webVC dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.webVC.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark -  记得要移除
-(void)cancelHandler {
    [_configuration.userContentController removeScriptMessageHandlerForName:@"backPage"];
}

-(void)dealloc {
    
}

@end
