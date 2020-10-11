//
//  MJRefresh+ReactiveExtention.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "MJRefresh.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshHeader (ReactiveExtension)
+ (instancetype)headerWithRefreshingCommand:(RACCommand *)refreshingCommand;
@end
@interface MJRefreshFooter(ReactiveExtension)
+ (instancetype)footerWithRefreshingCommand:(RACCommand *)refreshingCommand;
@end

NS_ASSUME_NONNULL_END
