//
//  WSFTransition.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign) BOOL isPush;//是否是push，反之则是pop

@property (nonatomic, assign) NSTimeInterval animationDuration;//动画时长
@end

NS_ASSUME_NONNULL_END
