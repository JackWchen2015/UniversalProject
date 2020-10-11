//
//  WSFLoginNetAPI.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFLoginNetAPI.h"

@implementation WSFLoginNetAPI
-(NSString*)path
{
    return @"signin";
}
-(NSString *)apiVersion
{
    return nil;
}
-(BOOL)isAuth
{
    return NO;
}
-(WSFRequestType)requestType
{
    return WSFRequestTypePost;
}
-(BOOL)shouldCache
{
    return NO;
}
-(BOOL)isRequestUsingJSON
{
    return YES;
}
@end
