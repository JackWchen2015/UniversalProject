//
//  WSFBasePageViewModel.h
//  WSFApp
//
//  Created by jack on 2020/9/15.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFNetworking+ReactiveExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface WSFBasePageViewModel : NSObject<WSFNetworkingListRACProtocol,WSFAPIManagerDataSource>
@property (nonatomic, readonly) BOOL hasNextPage;

-(void)setupRAC;
-(void)cancelRequest;
@end

NS_ASSUME_NONNULL_END
