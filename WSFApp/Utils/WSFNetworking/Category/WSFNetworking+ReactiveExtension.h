//
//  WSFDemo.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseAPIManager.h"
#import "WSFPageAPIManager.h"
#import "NSMapTable+WSFNetworking.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WSFNetworkingRACOperationProtocol;
typedef NSMapTable<NSString *,id<WSFNetworkingRACOperationProtocol>> WSFNetworkingRACTable;


@protocol WSFNetworkingRACOperationProtocol<NSObject>
- (RACCommand *)requestCommand;
- (RACCommand *)cancelCommand;
- (RACSignal *)requestErrorSignal;
- (RACSignal *)executionSignal;
@end

@protocol WSFNetworkingListRACOperationProtocol<WSFNetworkingRACOperationProtocol>
- (RACCommand *)refreshCommand;
- (RACCommand *)requestNextPageCommand;
@end

@protocol WSFNetworkingRACProtocol <NSObject>

@optional
- (id<WSFNetworkingRACOperationProtocol>)networkingRAC;
// 定义枚举在这允许获取多个APIManager的RAC
- (WSFNetworkingRACTable *)networkingRACs;
@end

@protocol WSFNetworkingListRACProtocol <NSObject>
@required
- (id<WSFNetworkingListRACOperationProtocol>)networkingRAC;
@end

@interface WSFBaseAPIManager (ReactiveExtension)<WSFNetworkingRACOperationProtocol>
@property (nonatomic, strong, readonly) RACCommand *requestCommand;
@property (nonatomic, strong, readonly) RACCommand *cancelCommand;
@property (nonatomic, strong, readonly) RACSignal *requestErrorSignal; //已为主线程
@property (nonatomic, strong, readonly) RACSignal *executionSignal;

- (RACSignal *)requestSignal;
@end
@interface WSFPageAPIManager (ReactiveExtension)<WSFNetworkingListRACOperationProtocol>
@property (nonatomic, strong, readonly) RACCommand *refreshCommand;
@property (nonatomic, strong, readonly) RACCommand *requestNextPageCommand;
@end

@interface RACCommand (WSFExtension)
@property (nonatomic, assign, setter=wsf_setTimestamp:) NSTimeInterval wsf_timestamp;
// 尝试execute，但是需要与上次执行的间隔大于seconds才会执行
- (BOOL)tryExecuteIntervalLongerThan:(NSInteger)seconds;
@end

NS_ASSUME_NONNULL_END
