//
//  WSFNetworkingConfiguration.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#ifndef WSFNetworkingConfiguration_h
#define WSFNetworkingConfiguration_h

#define WSFNetworkingLog TRUE


typedef NS_ENUM(NSUInteger, WSFResponseStatus) {
    // 底层仅有这四种状态
    WSFResponseStatusSuccess,
    WSFResponseStatusCancel,
    WSFResponseStatusErrorTimeout,
    WSFResponseStatusErrorUnknown
};

static BOOL kWSFShouldCacheDefault = NO;
static BOOL kWSFServiceIsOnline = NO;
static NSTimeInterval kWSFNetworkingTimeoutSeconds = 20.0f;
static NSTimeInterval kWSFCacheExpirationTimeDefault = 300; //

#endif /* WSFNetworkingConfiguration_h */
