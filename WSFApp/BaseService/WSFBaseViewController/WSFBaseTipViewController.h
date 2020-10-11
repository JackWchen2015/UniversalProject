//
//  WSFBaseTipViewController.h
//  WSFApp
//
//  Created by jack on 2020/9/11.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFBaseTipViewController : UIViewController
- (void)startAnimateWithTip:(nullable NSString *)tip;
- (void)stopAnimateWithTip:(nullable NSString *)tip;
@end

NS_ASSUME_NONNULL_END
