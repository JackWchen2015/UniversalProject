//
//  WSFResponseModel.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFResponseModel.h"
#import "NSURLRequest+WSFNetworking.h"
#import "WSFAuthParamsGenerator.h"
NSString * const WSFNetworkingResponseErrorKey = @"xyz.wanshifu.error.responsee";

@implementation WSFResponseError
@dynamic message;
- (instancetype)initWithMessage:(NSString *)message
                           code:(NSInteger)code
                      requestId:(NSInteger)requestId {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                         forKey:NSLocalizedDescriptionKey];
    self = [super initWithDomain:WSFNetworkingResponseErrorKey code:code userInfo:userInfo];
    if (self) {
        _requestId = requestId;
    }
    return self;
}
+ (WSFResponseError *)errorWithMessage:(NSString *)message
                                 code:(NSInteger)code
                            requestId:(NSInteger)requestId {
    return [[self alloc] initWithMessage:message code:code requestId:requestId];
}
#pragma mark -
- (NSString *)message {
    return [self localizedDescription];
}
#pragma mark -
- (NSString *)description {
    return [NSString stringWithFormat:@"[%lu]code:%ld, message:%@",self.requestId,self.code,self.message];
}
@end

@implementation WSFResponseModel
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSInteger)requestId
                               request:(NSURLRequest *)request
                              response:(NSURLResponse *)response
                          responseData:(NSData *)responseData
                                status:(WSFResponseStatus)status {
    self = [super init];
    if (self) {
        _contentString = responseString;
        _requestId = requestId;
        _response = response;
        _responseData = responseData;
        _request = request;
        _requestParams = request.wsf_requestParams;
        _isCache = NO;
    }
    return self;
}


- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        _contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        _requestId = 0;
        _request = nil;
        _responseData = [data copy];
        _requestParams = nil;
        _isCache = YES;
    }
    return self;
}

- (NSDictionary *)requestParamsExceptToken {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.requestParams];
    NSArray<NSString *> *keys = [WSFAuthParamsGenerator authParams].allKeys;
    // 这里保留UserId以防止不同用户的脏数据
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:WSFAuthParamsKeyUserId]) {
            [dict removeObjectForKey:obj];
        }
    }];
    return [dict copy];
}

@end

