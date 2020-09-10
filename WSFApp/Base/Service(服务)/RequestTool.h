//
//  RequestTool.h
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRequestTool.h"
#import "HomeRequestTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface RequestTool : NSObject

+ (instancetype)sharedRequestTool;

/** 用户 */
@property(nonatomic,strong)UserRequestTool        *userRequestTool;
/** 首页 */
@property(nonatomic,strong)HomeRequestTool        *homeRequestTool;

@end

NS_ASSUME_NONNULL_END
