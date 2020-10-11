//
//  WSFAuthParamsGenerator.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const WSFAuthParamsKeyUserId;
@interface WSFAuthParamsGenerator : NSObject
+ (NSDictionary *)authParams;
@end

NS_ASSUME_NONNULL_END
