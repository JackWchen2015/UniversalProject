//
//  BaseTabBar.h
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BaseTabBar;

@protocol BaseTabBarDelegate <NSObject>

@optional

- (void)tabBarMiddle_BTClick:(BaseTabBar *)tabBar;

@end


@interface BaseTabBar : UITabBar

@property (nonatomic, weak) id<BaseTabBarDelegate> myDelegate ;

@end
