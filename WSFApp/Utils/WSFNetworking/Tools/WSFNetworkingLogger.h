//
//  WSFNetworkingLogger.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface WSFNetworkingLogger : NSObject
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                           path:(NSString *)path
                         isJSON:(BOOL)isJSON
                         params:(id)requestParams
                    requestType:(NSString *)type;

+ (void)logResponseWithRequest:(NSURLRequest *)request
                          path:(NSString *)path
                        params:(id)requestParams
                      response:(NSString *)response;

+ (void)logInfo:(NSString *)msg;
+ (void)logInfo:(NSString *)msg label:(NSString *)label;
+ (void)logError:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
