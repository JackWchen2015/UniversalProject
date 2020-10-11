//
//  WSFCacheProxy.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFCacheProxy : NSObject
+ (instancetype)sharedInstance;


- (NSData *)cacheForParams:(NSDictionary *)params
                      host:(NSString *)host
                      path:(NSString *)path
                apiVersion:(NSString *)version;

- (NSData *)cacheForKey:(NSString *)key;



- (void)setCacheData:(NSData *)data
           forParams:(NSDictionary *)params
                host:(NSString *)host
                path:(NSString *)path
          apiVersion:(NSString *)version
  withExpirationTime:(NSTimeInterval)length;

- (void)setCacheData:(NSData *)data forKey:(NSString *)key  withExpirationTime:(NSTimeInterval)length;
@end

NS_ASSUME_NONNULL_END
