//
//  UITabBar+WSFCustomBadge.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CustomBadgeType){
    kCustomBadgeStyleRedDot,
    kCustomBadgeStyleNumber,
    kCustomBadgeStyleNone
};

@interface UITabBar (WSFCustomBadge)
/**
 *设置tab上icon的宽度，用于调整badge的位置
 */
- (void)setTabIconWidth:(CGFloat)width;

/**
 *设置badge的top
 */
- (void)setBadgeTop:(CGFloat)top;

/**
 *设置badge样、数字
 */
- (void)setBadgeStyle:(CustomBadgeType)type value:(NSInteger)badgeValue atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
