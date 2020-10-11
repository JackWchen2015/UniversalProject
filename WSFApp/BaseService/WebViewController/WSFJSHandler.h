//
//  WSFJSHandle.h
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WSFJSHandler : NSObject<WKScriptMessageHandler>
@property (nonatomic,weak,readonly) UIViewController * webVC;
@property (nonatomic,strong,readonly) WKWebViewConfiguration * configuration;

-(instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;

-(void)cancelHandler;
@end

NS_ASSUME_NONNULL_END
