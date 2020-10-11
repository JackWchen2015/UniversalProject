//
//  demoeee.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)wsf_methodSwizzlingWithTarget:(SEL)originalSelector
                               using:(SEL)swizzledSelector
                            forClass:(Class)clazz;
@end

@interface NSString (WSFNetworking)
- (NSString *)wsf_md5;
+ (NSString *)wsf_urlStringForHost:(NSString *)host
                             path:(NSString *)path
                       apiVersion:(NSString *)version;
@end

@interface NSData (WSFNetworking)
- (NSString *)wsf_md5;
@end


@interface NSDictionary (WSFNetworking)
- (NSString *)wsf_md5;
@end

NS_ASSUME_NONNULL_END
