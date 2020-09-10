//
//  UserRequestTool.h
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRequestTool : NSObject


/**
 *  login 用户登录
 */
-(void)loginWithParameters:(NSDictionary *)parameters
             FinishedLogin:(void(^)(id responseObject))FinishedLogin;



@end

NS_ASSUME_NONNULL_END
