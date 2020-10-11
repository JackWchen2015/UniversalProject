//
//  WSFTokenAPIRefresher.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface WSFTokenAPIRefresher : WSFBaseAPIManager<WSFAPIManagerProtocol>
- (void)needRefresh;


+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
