//
//  WSFBaseViewModel.m
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseViewModel.h"

@implementation WSFBaseViewModel


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

-(void)setupRAC
{
    
}

//取消请求
- (void)cancelRequest
{
    if (self.networkingRAC) {
        [self.networkingRAC.cancelCommand execute:nil];
    }
}

- (void)dealloc
{
    [self cancelRequest];
}
@end
