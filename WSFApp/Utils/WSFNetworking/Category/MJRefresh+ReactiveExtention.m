//
//  MJRefresh+ReactiveExtention.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "MJRefresh+ReactiveExtention.h"

@implementation MJRefreshHeader (ReactiveExtension)
+ (instancetype)headerWithRefreshingCommand:(RACCommand *)refreshingCommand {
    @weakify(refreshingCommand);
    return [self headerWithRefreshingBlock:^{
        @strongify(refreshingCommand);
        [refreshingCommand execute:nil];
    }];
}
@end

@implementation MJRefreshFooter(ReactiveExtension)
+ (instancetype)footerWithRefreshingCommand:(RACCommand *)refreshingCommand {
    @weakify(refreshingCommand);
    return [self footerWithRefreshingBlock:^{
        @strongify(refreshingCommand);
        [refreshingCommand execute:nil];
    }];
}
@end
