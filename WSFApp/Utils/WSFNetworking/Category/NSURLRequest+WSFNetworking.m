//
//  NSURLRequest+WSFNetworking.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "NSURLRequest+WSFNetworking.h"
#import <objc/runtime.h>
@implementation NSURLRequest (WSFNetworking)
- (void)setWsf_requestParams:(NSDictionary *)wsf_requestParams
{
     objc_setAssociatedObject(self, @selector(wsf_requestParams), wsf_requestParams, OBJC_ASSOCIATION_COPY);
    
}
-(NSDictionary *)wsf_requestParams
{
     return objc_getAssociatedObject(self, @selector(wsf_requestParams));
}
@end
