//
//  WSFBaseWebViewController.h
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSFBaseWebViewController : WSFWebViewController
//在多级跳转后，是否在返回按钮右侧展示关闭按钮
@property(nonatomic,assign) BOOL isShowCloseBtn;
@end

NS_ASSUME_NONNULL_END
