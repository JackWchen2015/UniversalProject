//
//  NSMapTable+WSFNetworking.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "NSMapTable+WSFNetworking.h"

@implementation NSMapTable (WSFNetworking)
- (id)objectForKeyedSubscript:(id <NSCopying>)key {
    return [self objectForKey:key];
}
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
    [self setObject:obj forKey:key];
}
@end
