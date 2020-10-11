//
//  WSFNetworkingLogger.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFNetworkingLogger.h"
#import "WSFNetworkingConfiguration.h"
@implementation WSFNetworkingLogger
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                           path:(NSString *)path
                         isJSON:(BOOL)isJSON
                         params:(id)requestParams
                    requestType:(NSString *)type {
#if WSFNetworkingLog && DEBUG
    NSMutableString *log = [NSMutableString string];
    [log appendString:@"\n↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘ [ WSFNetworking Request Info ] ↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙"];
    [log appendFormat:@"\nReuqest Path   : %@", path];
    [log appendFormat:@"\nReuqest Params : %@", requestParams];
    [log appendFormat:@"\nParams is JSON : %@", isJSON?@"YES":@"NO"];
    [log appendFormat:@"\nRequest Type   : %@", type];
    [log appendFormat:@"\nRaw Request    : %@", request];
    [log appendString:@"\n↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗ [ WSFNetworking Request Info End ] ↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖"];
    NSLog(@"%@",log);
#endif
}

+ (void)logResponseWithRequest:(NSURLRequest *)request
                          path:(NSString *)path
                        params:(id)requestParams
                      response:(NSString *)response {
#if WSFNetworkingLog && DEBUG
    NSMutableString *log = [NSMutableString string];
    [log appendString:@"\n↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘ [ WSFNetworking Response Info ] ↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙"];
    [log appendFormat:@"\nReuqest Path   : %@", path];
    [log appendFormat:@"\nReuqest Params : %@", requestParams];
    [log appendFormat:@"\nResponse String: %@", response];
    [log appendString:@"\n↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗ [ WSFNetworking Response Info End ] ↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖"];
    NSLog(@"%@",log);
#endif
}

+ (void)logInfo:(NSString *)msg {
    [self logInfo:msg label:@"Log"];
}

+ (void)logInfo:(NSString *)msg label:(NSString *)label {
#if DEBUG
    NSMutableString *log = [NSMutableString string];
    [log appendFormat:@"\n↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘ [ WSFNetworking %@ Info ] ↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙",label];
    [log appendFormat:@"\n%@", msg];
    [log appendFormat:@"\n↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗ [ WSFNetworking %@ Info End ] ↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖",label];
    NSLog(@"%@",log);
#endif
}

+ (void)logError:(NSString *)msg {
#if DEBUG
    NSMutableString *log = [NSMutableString string];
    [log appendString:@"\n↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘↘ [ WSFNetworking Error Info ] ↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙↙"];
    [log appendFormat:@"\n%@", msg];
    [log appendString:@"\n↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗↗ [ WSFNetworking Error Info End ] ↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖↖"];
    NSLog(@"%@",log);
#endif
}
@end

