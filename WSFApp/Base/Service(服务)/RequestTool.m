//
//  RequestTool.m
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+ (instancetype)sharedRequestTool
{
    static RequestTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            
            tool = [RequestTool new];
            
            tool.userRequestTool    = [[UserRequestTool alloc]init];
            tool.homeRequestTool    = [[HomeRequestTool alloc]init];
        }
    });
    return tool;
}
@end
