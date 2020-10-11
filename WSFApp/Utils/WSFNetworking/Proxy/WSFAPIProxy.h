//
//  WSFAPIProxy.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFResponseModel.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^WSFAPIProxySuccess)(WSFResponseModel *response);
typedef void(^WSFAPIProxyFail)(WSFResponseError *error);

@interface WSFAPIProxy : NSObject
+ (instancetype)sharedInstance;

- (BOOL)isReachable;

- (NSInteger)loadGETWithParams:(NSDictionary *)params
                       useJSON:(BOOL)useJSON
                          host:(NSString *)host
                          path:(NSString *)path
                    apiVersion:(NSString *)version
                       success:(WSFAPIProxySuccess)success
                          fail:(WSFAPIProxyFail)fail;

- (NSInteger)loadPOSTWithParams:(NSDictionary *)params
                        useJSON:(BOOL)useJSON
                           host:(NSString *)host
                           path:(NSString *)path
                     apiVersion:(NSString *)version
                        success:(WSFAPIProxySuccess)success
                           fail:(WSFAPIProxyFail)fail;
- (NSInteger)loadPATCHWithParams:(NSDictionary *)params
                        useJSON:(BOOL)useJSON
                           host:(NSString *)host
                           path:(NSString *)path
                     apiVersion:(NSString *)version
                        success:(WSFAPIProxySuccess)success
                           fail:(WSFAPIProxyFail)fail;
- (NSNumber *)loadRequest:(NSURLRequest *)request
                  success:(WSFAPIProxySuccess)success
                     fail:(WSFAPIProxyFail)fail;

- (void)cancelRequestWithRequestId:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIdList:(NSArray *)requestIdList;
@end

@class WSFBaseAPIManager;
@protocol WSFAPIManager;
@interface WSFAPIProxy (WSFRequestGenerator)
+ (NSURLRequest *)requestWithParams:(NSDictionary *)params
                            useJSON:(BOOL)useJSON
                             method:(NSString *)method
                               host:(NSString *)host
                               path:(NSString *)path
                         apiVersion:(NSString *)version;
@end

NS_ASSUME_NONNULL_END
