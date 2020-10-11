//
//  WSFMainTabBarViewController.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFMainTabBarController : UITabBarController
/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END
