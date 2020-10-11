//
//  WSFDemo.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFNetworking+ReactiveExtension.h"
#import "Foundation+WSFNetworking.h"
#import <objc/runtime.h>

@interface WSFBaseAPIManager(_ReactiveExtension)
@property (nonatomic, assign) NSInteger requestId;
@end

@implementation WSFBaseAPIManager (_ReactiveExtension)
- (void)setRequestId:(NSInteger)requestId {
    objc_setAssociatedObject(self, @selector(requestId), @(requestId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)requestId {
    return [objc_getAssociatedObject(self, @selector(requestId)) integerValue];
}
@end
@implementation WSFBaseAPIManager (ReactiveExtension)

- (RACSignal *)requestSignal {
    @weakify(self);
    RACSignal *requestSignal =
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        RACSignal *successSignal = [self rac_signalForSelector:@selector(afterPerformSuccessWithResponseModel:)];
        [[successSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        
        RACSignal *failSignal = [self rac_signalForSelector:@selector(afterPerformFailWithResponseError:)];
        [[failSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] subscribeNext:^(id x) {
            NSLog(@"请求失败 %@",x);
            [subscriber sendError:x];
        }];
        return nil;
    }] replayLazily] takeUntil:self.rac_willDeallocSignal];
    return requestSignal;
}

- (RACCommand *)requestCommand {
    RACCommand *requestCommand = objc_getAssociatedObject(self, @selector(requestCommand));
    if (requestCommand == nil) {
        @weakify(self);
        requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            if ([input respondsToSelector:@selector(boolValue)] && [input boolValue]) {
                self.requestId = [self loadDataWithoutCache];
            } else {
                self.requestId = [self loadData];
            }
            return [self.requestSignal takeUntil:self.cancelCommand.executionSignals];
        }];
        objc_setAssociatedObject(self, @selector(requestCommand), requestCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requestCommand;
}

- (RACCommand *)cancelCommand {
    RACCommand *cancelCommand = objc_getAssociatedObject(self, @selector(cancelCommand));
    if (cancelCommand == nil) {
        @weakify(self);
        cancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self cancelRequestWithRequestId:self.requestId];
            NSLog(@"cancelCommand 取消请求:%lu",self.requestId);
            return [RACSignal empty];
        }];
        objc_setAssociatedObject(self, @selector(cancelCommand), cancelCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cancelCommand;
}

- (RACSignal *)requestErrorSignal {
    return [self.requestCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)executionSignal {
    return [self.requestCommand.executionSignals switchToLatest];
}

@end


@implementation WSFPageAPIManager (ReactiveExtension)
- (RACCommand *)requestCommand {
    @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ requestCommand error",[self class]]
                                   reason:@"Don't call this Method. Call  refreshCommand or requestNextPageCommand instead."
                                 userInfo:nil];
}

- (RACCommand *)refreshCommand {
    RACCommand *refreshCommand = objc_getAssociatedObject(self, @selector(refreshCommand));
    if (refreshCommand == nil) {
        @weakify(self);
        refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self reset];
            NSInteger requestId;
            if ([input respondsToSelector:@selector(boolValue)] && [input boolValue]) {
                requestId = [self loadNextPageWithoutCache];
            } else {
                requestId = [self loadNextPage];
            }
            
            if (requestId != kPageIsLoading) {
                self.requestId = requestId;
            }
            NSLog(@"[refreshCommand] 发出请求:%lu",requestId);
            return self.requestSignal;
        }];
        objc_setAssociatedObject(self, @selector(refreshCommand), refreshCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return refreshCommand;
}


- (RACCommand *)requestNextPageCommand {
    RACCommand *requestNextPageCommand = objc_getAssociatedObject(self, @selector(requestNextPageCommand));
    if (requestNextPageCommand == nil) {
        @weakify(self);
        requestNextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSInteger requestId = [self loadNextPage];
            if (requestId != kPageIsLoading) {
                self.requestId = requestId;
            }
            NSLog(@"[requestNextPageCommand] 发出请求:%lu",requestId);
            return self.requestSignal;
        }];
        objc_setAssociatedObject(self, @selector(requestNextPageCommand), requestNextPageCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requestNextPageCommand;
}

- (RACSignal *)requestErrorSignal {
    return [[RACSignal merge:@[self.refreshCommand.errors, self.requestNextPageCommand.errors]]
            subscribeOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)executionSignal {
    RACSignal *refreshExecutionSignal =
    [[self.refreshCommand.executionSignals switchToLatest] map:^id(id value) {
        return @(YES);
    }];
    
    RACSignal *requestNextPageExecutionSignal =
    [[self.requestNextPageCommand.executionSignals switchToLatest] map:^id(id value) {
        return @(NO);
    }];
    return [RACSignal merge:@[refreshExecutionSignal, requestNextPageExecutionSignal]];
}
@end

@implementation RACCommand (WSFExtension)
+ (void)load {
    [NSObject wsf_methodSwizzlingWithTarget:@selector(execute:)
                                     using:@selector(wsf_execute:)
                                  forClass:[RACCommand class]];
}

- (RACSignal *)wsf_execute:(id)input {
    self.wsf_timestamp = [NSDate timeIntervalSinceReferenceDate];
    return [self wsf_execute:input];
}

- (NSTimeInterval)wsf_timestamp {
    return [objc_getAssociatedObject(self, @selector(wsf_timestamp)) doubleValue];
}

- (void)wsf_setTimestamp:(NSTimeInterval)timestamp {
    objc_setAssociatedObject(self, @selector(wsf_timestamp), @(timestamp), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)tryExecuteIntervalLongerThan:(NSInteger)seconds {
    BOOL result = NO;
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if (now - self.wsf_timestamp > seconds) {
        result = YES;
        [self execute:nil];
        
    }
    return result;
}
@end

