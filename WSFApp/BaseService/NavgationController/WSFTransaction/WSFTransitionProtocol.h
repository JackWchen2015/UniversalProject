//
//  WSFTransitionProtocol.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WSFTransitionProtocol <NSObject>
@optional

/**
 转场动画的目标View 需要转场动画的对象必须实现该方法并返回要做动画的View

 @return view
 */
-(UIView *)targetTransitionView;


/**
 *  是否是需要实现转场效果，不需要转场动画可不实现，需要必须实现并返回YES
 *
 *  @return 是否
 */
-(BOOL)isNeedTransition;
@end

NS_ASSUME_NONNULL_END
