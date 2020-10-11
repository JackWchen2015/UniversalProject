//
//  WSFCacheProxy.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFCacheProxy.h"
#import "Foundation+WSFNetworking.h"
#import <YYCache/YYCache.h>
#import "WSFSignatureGenerator.h"
#import "WSFNetworkingLogger.h"
#import "WSFNetworkingConfiguration.h"

static NSString * const  WSFNetworkingCacheKeyCacheData = @"xyz.wanshifu.WSFNetworkingCacheKeyCacheData";
static NSString * const  WSFNetworkingCacheKeyCacheTime = @"xyz.wanshifu.WSFNetworkingCacheKeyCacheTime";
static NSString * const  WSFNetworkingCacheKeyCacheAgeLength = @"xyz.wanshifu.WSFNetworkingCacheKeyCacheAgeLength";

static NSString * const  kWSFNetworkingCache = @"xyz.wanshifu.WSFNetworkingCache";


@interface WSFCacheProxy ()
@property (nonatomic, strong) YYCache *cache;
@end


@implementation WSFCacheProxy
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static WSFCacheProxy *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WSFCacheProxy alloc] init];
    });
    return instance;
}

- (NSData *)cacheForParams:(NSDictionary *)params host:(NSString *)host path:(NSString *)path apiVersion:(NSString *)version {
    NSString *urlString = [NSString wsf_urlStringForHost:host path:path apiVersion:version];
    NSString *key = [WSFSignatureGenerator signatureWithRequestPath:urlString params:params extra:nil];
    return [self cacheForKey:key];
}

- (NSData *)cacheForKey:(NSString *)key {
    NSDictionary *cacheDict = [self.cache objectForKey:key];
    
    NSData *cacheData = cacheDict[WSFNetworkingCacheKeyCacheData];
    NSTimeInterval cacheTime = [cacheDict[WSFNetworkingCacheKeyCacheTime] doubleValue];
    NSInteger cacheAgeLength = [cacheDict[WSFNetworkingCacheKeyCacheAgeLength] integerValue];
    
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if (now - cacheTime > cacheAgeLength) {
        [WSFNetworkingLogger logInfo:@"已过期" label:@"Cache"];
        [self.cache removeObjectForKey:key];
        return nil;
    } else {
        if ([cacheData isKindOfClass:[NSData class]]) {
            NSString *log =[NSString stringWithFormat:@"读取缓存:\n%@",[[NSString alloc] initWithData:cacheData encoding:NSUTF8StringEncoding]];
            [WSFNetworkingLogger logInfo:log label:@"Cache"];
            return cacheData;
        } else {
            NSString *log = [NSString stringWithFormat:@"Return nil because cache data(%@) is NOT kind of NSData.",[cacheData class]];
            [WSFNetworkingLogger logError:log];
            return nil;
        }
    }
    
}


- (void)setCacheData:(NSData *)data
           forParams:(NSDictionary *)params
                host:(NSString *)host
                path:(NSString *)path
          apiVersion:(NSString *)version
  withExpirationTime:(NSTimeInterval)length {
    NSString *urlString = [NSString wsf_urlStringForHost:host path:path apiVersion:version];
    NSString *key = [WSFSignatureGenerator signatureWithRequestPath:urlString params:params extra:nil];
    [self setCacheData:data forKey:key withExpirationTime:length];
}

- (void)setCacheData:(NSData *)data forKey:(NSString *)key withExpirationTime:(NSTimeInterval)length {
    if (data == nil) {
        return;
    }
    if ([data isKindOfClass:[NSData class]]) {
        NSDictionary *cacheDict =
        @{
          WSFNetworkingCacheKeyCacheData: data,
          WSFNetworkingCacheKeyCacheTime: @([NSDate timeIntervalSinceReferenceDate]),
          WSFNetworkingCacheKeyCacheAgeLength : @(length),
          };
        
        [self.cache setObject:cacheDict forKey:key];
        
        NSString *log =[NSString stringWithFormat:@"写入缓存:\n %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
        [WSFNetworkingLogger logInfo:log label:@"Cache"];
    } else {
        [WSFNetworkingLogger logError:
         [NSString stringWithFormat:@"Cache data(%@) is NOT kind of NSData",[data class]]];
    }
}

- (YYCache *)cache {
    if (_cache == nil) {
        _cache = [[YYCache alloc] initWithName:kWSFNetworkingCache];
        _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    }
    return _cache;
}
@end
