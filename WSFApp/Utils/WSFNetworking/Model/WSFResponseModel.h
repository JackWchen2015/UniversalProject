//
//  WSFResponseModel.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFNetworkingConfiguration.h"
NS_ASSUME_NONNULL_BEGIN


#define WSFResponseError(MSG,CODE,ID) [WSFResponseError errorWithMessage:MSG code:CODE requestId:ID]

@interface WSFResponseError : NSError
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, strong) NSDictionary *response;

- (instancetype)initWithMessage:(NSString *)message
                           code:(NSInteger)code
                      requestId:(NSInteger)requestId;

+ (WSFResponseError *)errorWithMessage:(NSString *)message
                                 code:(NSInteger)code
                            requestId:(NSInteger)requestId;
@end

@interface WSFResponseModel : NSObject
@property (nonatomic, assign, readonly) WSFResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSURLResponse *response;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;
@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSInteger)requestId
                               request:(NSURLRequest *)request
                              response:(NSURLResponse *)response
                          responseData:(NSData *)responseData
                                status:(WSFResponseStatus)status;

- (NSDictionary *)requestParamsExceptToken;
@end

NS_ASSUME_NONNULL_END
