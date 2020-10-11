//
//  WSFBaseAPIManager.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseAPIManager.h"
#import "WSFAPIProxy.h"
#import "WSFCacheProxy.h"
#import "WSFAuthParamsGenerator.h"
#import "WSFTokenAPIRefresher.h"
#import "YYModel.h"
#import <libkern/OSAtomic.h>


NSString * const WSFAPIBaseManagerRequestId = @"xyz.wanshifu.WSFAPIBaseManagerRequestID";

#define WSFLoadRequest(REQUEST_METHOD, REQUEST_ID)                                               \
{\
__weak typeof(self) weakSelf = self;\
REQUEST_ID = [[WSFAPIProxy sharedInstance] load##REQUEST_METHOD##WithParams:finalAPIParams useJSON:self.isRequestUsingJSON host:self.host path:self.child.path apiVersion:self.child.apiVersion success:^(WSFResponseModel *response) {\
__strong typeof(weakSelf) strongSelf = weakSelf;\
[strongSelf dataDidLoad:response];\
} fail:^(WSFResponseError *error) {\
__strong typeof(weakSelf) strongSelf = weakSelf;\
[strongSelf dataLoadFailed:error];\
}];\
self.requestIdMap[@(REQUEST_ID)]= @(REQUEST_ID);\
}\


static void thread_safe_execute(dispatch_block_t block) {
    static OSSpinLock yl_networking_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&yl_networking_lock);
    block();
    OSSpinLockUnlock(&yl_networking_lock);
}

@interface WSFBaseAPIManager() {
    BOOL forceUpdate;
}
@property (nonatomic, assign, readonly) NSUInteger createTime;
@property (nonatomic, strong, readwrite) id rawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;
@property (nonatomic, strong) NSMutableSet *dependencySet;


// 业务层得到的requestId 与 APIProxy得到的requsetId是不同的，这里即保存着他们的对应关系
// 之所以这么设计是为了在网络层重新发起请求的时候，让业务层是不可感知。
@property (nonatomic, strong) NSMutableDictionary *requestIdMap;

@property (nonatomic, weak) WSFBaseAPIManager<WSFAPIManagerProtocol>* child;
@end

@implementation WSFBaseAPIManager
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(WSFAPIManagerProtocol)]) {
            self.child = (id <WSFAPIManagerProtocol>)self;
            _createTime = (NSUInteger)[NSDate timeIntervalSinceReferenceDate];
            _continueMutex = dispatch_semaphore_create(0);
            _dependencySet = [NSMutableSet set];
            _requestIdMap = [NSMutableDictionary dictionary];
            forceUpdate = NO;
        } else {
            @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ init failed",[self class]]
                                           reason:@"Subclass of WSFAPIBaseManager should implement <WSFAPIManager>"
                                         userInfo:nil];
        }
    }
    return self;
}

- (NSUInteger)hash {
    return [self.class hash] ^ self.createTime;
}

- (NSString *)host {
    return @"kServerURL";
}

- (WSFRequestType)requestType {
    return WSFRequestTypePost;
}

- (BOOL)isResponseJSONable {
    return YES;
}

- (BOOL)isRequestUsingJSON {
    return YES;
}

- (BOOL)shouldCache {
    return kWSFShouldCacheDefault;
}

- (NSInteger)cacheExpirationTime {
    return kWSFCacheExpirationTimeDefault;
}

- (BOOL)isReachable {
    return [[WSFAPIProxy sharedInstance] isReachable];
}

- (BOOL)isLoading {
    if (self.requestIdMap.count == 0) {
        _isLoading = NO;
    }
    return _isLoading;
}

- (void)addDependency:(WSFBaseAPIManager *)apiManager {
    if(apiManager == nil) return;
    // 此处用NSMutableSet而没用NSHash​Table
    // 是由于此处必须是强引用，以防止在此apiManager请求前，所依赖的apiManager被释放，而导致无法判断依赖的apiManager是否完成
    // 此处会导致被依赖的apiManager只能等待所有产生该依赖的apiManager被释放完后才能释放。
    thread_safe_execute(^{
        [self.dependencySet addObject:apiManager];
    });
}

- (void)removeDependency:(WSFBaseAPIManager *)apiManager {
    if(apiManager == nil) return;
    thread_safe_execute(^{
        [self.dependencySet removeObject:apiManager];
    });
}
- (NSInteger)loadData {
    
    if (self.child.isAuth) {
        // 在此给所有的需要认证信息的APIManager添加对YLTokenRefresher的依赖，利用AOP的形式用户无感知地刷新Token
        // 由于采用的是NSMutableSet，也无需担心重复添加的问题
        // 再者不用使用dispatch_once，以防止某些情况譬如动态更新时改掉isAuth时，无法正确添加依赖关系
        [self addDependency:[WSFTokenAPIRefresher sharedInstance]];
    }
    
    static NSInteger requestIndex = 0;
    
    __block NSInteger openRequestId;
    thread_safe_execute(^{
        requestIndex++;
        openRequestId = requestIndex;
    });
    
    [self waitForDependency:^{
        NSDictionary *params = [self.dataSource paramsForAPI:self];
        NSInteger requestId = [self loadDataWithParams:params];
        self.requestIdMap[@(openRequestId)] = @(requestId);
    }];
    return openRequestId;
}

- (NSInteger)loadDataWithoutCache {
    //    self.shouldCache = NO;
    forceUpdate = YES;
    return [self loadData];
}

// 不将此方法开放出去是为了强制使用dataSource来提供数据，类同UITableView
- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    NSMutableDictionary *finalAPIParams = [[NSMutableDictionary alloc] init];
    if (params) {
        [finalAPIParams addEntriesFromDictionary:apiParams];
    }
    if (self.child.isAuth) {
        NSDictionary *authParams = [WSFAuthParamsGenerator authParams];
        if (authParams) {
            [finalAPIParams addEntriesFromDictionary:authParams];
        } else {
            [self dataLoadFailed:
             [WSFBaseAPIManager errorWithRequestId:requestId
                                           status:WSFAPIManagerResponseStatusNeedLogin]];
        }
    }
    
    if ([self shouldLoadRequestWithParams:finalAPIParams]) {
        if (!forceUpdate && [self shouldCache] && [self tryLoadResponseFromCacheWithParams:finalAPIParams]) {
            return 0;
        }
        
        if ([[WSFAPIProxy sharedInstance] isReachable]) {
            self.isLoading = YES;
            switch (self.child.requestType) {
                    case WSFRequestTypeGet:
                    WSFLoadRequest(GET, requestId);
                    break;
                    case WSFRequestTypePost:
                    WSFLoadRequest(POST, requestId);
                    break;
                case WSFRequestTypePatch:
                    WSFLoadRequest(PATCH, requestId);
                default:
                    break;
            }
            
            NSMutableDictionary *params = [finalAPIParams mutableCopy];
            params[WSFAPIBaseManagerRequestId] = @(requestId);
            [self afterLoadRequestWithParams:params];
            return requestId;
        } else {
            [self dataLoadFailed:
             [WSFBaseAPIManager errorWithRequestId:requestId
                                           status:WSFAPIManagerResponseStatusNoNetwork]];
            return requestId;
        }
    }
    return requestId;
}



#pragma mark - api callbacks
- (void)dataDidLoad:(WSFResponseModel *)responseModel {
    self.isLoading = NO;
    
    [self.requestIdMap removeObjectForKey:@(responseModel.requestId)];
    if ([self isResponseJSONable]) {
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseModel.responseData
                                                                 options:NSJSONReadingMutableLeaves
                                                                   error:&error];
        if (error != nil) {
            WSFResponseError *error = [WSFBaseAPIManager errorWithRequestId:responseModel.requestId
                                                                   status:WSFAPIManagerResponseStatusParsingError];
            error.response = jsonDict;
            [self dataLoadFailed:error];
            return;
        }
        self.rawData = jsonDict;
//#warning 如果你的返回值里也有status，请取消下面注释
        NSInteger status = [jsonDict[@"code"] integerValue];
        if (status != WSFAPIManagerResponseStatusSuccess) {
            WSFResponseError *error = [WSFBaseAPIManager errorWithRequestId:responseModel.requestId
                                                                   status:status
                                                                    extra:jsonDict[@"msg"]];
            error.response = jsonDict;
            [self dataLoadFailed:error];
            return;
        }
    } else {
        self.rawData = [responseModel.responseData copy];
    }
    if([self isResponseDataCorrect:responseModel]) {
        if ([self beforePerformSuccessWithResponseModel:responseModel]) {
            NSLog(@"数据加载完毕");
            [self.delegate apiManagerLoadDataSuccess:self];
            if ([self shouldCache] && !responseModel.isCache) {
                [[WSFCacheProxy sharedInstance] setCacheData:responseModel.responseData forParams:responseModel.requestParamsExceptToken host:self.host path:self.child.path apiVersion:self.child.apiVersion withExpirationTime:self.child.cacheExpirationTime];
            }
            
            dispatch_semaphore_signal(self.continueMutex);
        }
        [self afterPerformSuccessWithResponseModel:responseModel];
    } else {
        [self dataLoadFailed:
         [WSFBaseAPIManager errorWithRequestId:responseModel.requestId
                                       status:WSFAPIManagerResponseStatusParsingError]];
    }
    forceUpdate = NO;
}

- (void)dataLoadFailed:(WSFResponseError *)error {
    // 将requestId更改为对外的requestId
    __block NSInteger openRequestId = 0;
    [self.requestIdMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj integerValue] == error.requestId) {
            openRequestId = [key integerValue];
        }
    }];
    
    NSDictionary *response = error.response;
    error = WSFResponseError(error.message, error.code, openRequestId);
    error.response = response;
    
    if(error.code == WSFResponseStatusCancel) {
        // 处理请求被取消
        if([self.delegate respondsToSelector:@selector(apiManagerLoadDidCancel:)]) {
            [self.delegate apiManagerLoadDidCancel:self];
        }
        [self afterPerformCancel];
        return;
    }
    if (error.code == WSFAPIManagerResponseStatusTokenExpired) {
        [[WSFTokenAPIRefresher sharedInstance] needRefresh];
        [self waitForDependency:^{
            // 重启访问
            self.requestIdMap[@(error.requestId)] = @([self loadData]);
        }];
        return;
    }
    if ([self beforePerformFailWithResponseError:error]) {
        [self.requestIdMap removeObjectForKey:@(error.requestId)];
        if ([self.delegate respondsToSelector:@selector(apiManager:loadDataFail:)]) {
            [self.delegate apiManager:self loadDataFail:error];
        }
        [self afterPerformFailWithResponseError:error];
    }
}


#pragma mark - public API
- (void)cancelAllRequests {
    [[WSFAPIProxy sharedInstance] cancelRequestWithRequestIdList:self.requestIdMap.allValues];
    [self.requestIdMap removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestId {
    NSNumber *realRequstId = self.requestIdMap[@(requestId)];
    [self.requestIdMap removeObjectForKey:@(requestId)];
    [[WSFAPIProxy sharedInstance] cancelRequestWithRequestId:realRequstId];
}

- (id)fetchData {
    return [self fetchDataWithReformer:nil];
}

- (id)fetchDataWithReformer:(id<WSFAPIManagerDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(apiManager:reformData:)]) {
        resultData = [reformer apiManager:self reformData:self.rawData];
    } else {
        resultData = [self.rawData mutableCopy];
    }
    return resultData;
}

- (id)fetchDataFromModel:(Class)clazz {
    NSError *error;
//    id model = [NSObject modelOfClass:clazz fromJSONDictionary:[self fetchData][@"data"] error:&error];
    id model=[clazz  yy_modelWithDictionary:[self fetchData][@"data"]];
    NSLog(@"Error:%@",error);
    return model;
}

#pragma mark - private API

- (void)waitForDependency:(dispatch_block_t)block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (WSFBaseAPIManager *apiManager in self.dependencySet) {
            NSLog(@"%@ wait %@",self, apiManager);
            dispatch_semaphore_wait(apiManager.continueMutex, DISPATCH_TIME_FOREVER);
            // 得到后立刻释放，防止其他请求无法进行
            NSLog(@"%@ Done",apiManager);
            dispatch_semaphore_signal(apiManager.continueMutex);
        }
        if(block) {
            block();
        }
    });
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    if (childIMP == selfIMP) {
        return params;
    } else {
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

- (BOOL)tryLoadResponseFromCacheWithParams:(NSDictionary *)params {
    NSData *cache = [[WSFCacheProxy sharedInstance] cacheForParams:params host:self.host path:self.child.path apiVersion:self.child.apiVersion];
    if (cache == nil) {
        return NO;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            WSFResponseModel *responseModel = [[WSFResponseModel alloc] initWithData:cache];
            [self dataDidLoad:responseModel];
        });
    });
    
    return YES;
}

#define WSFResponseErrorWithMSG(MSG) WSFResponseError(MSG, status, requestId)
+ (WSFResponseError *)errorWithRequestId:(NSInteger)requestId
                                 status:(WSFAPIManagerResponseStatus)status {
    return [self errorWithRequestId:requestId status:status extra:nil];
}
+ (WSFResponseError *)errorWithRequestId:(NSInteger)requestId
                                 status:(WSFAPIManagerResponseStatus)status
                                  extra:(NSString *)message {
    switch (status) {
            case WSFAPIManagerResponseStatusParsingError:
            return WSFResponseErrorWithMSG(@"数据解析错误");
            case WSFAPIManagerResponseStatusTimeout:
            return WSFResponseErrorWithMSG(@"请求超时");
            case WSFAPIManagerResponseStatusNoNetwork:
            return WSFResponseErrorWithMSG(@"当前网络已断开");
            case WSFAPIManagerResponseStatusTokenExpired:
            return WSFResponseErrorWithMSG(@"token已过期");
            case WSFAPIManagerResponseStatusNeedLogin:
            return WSFResponseErrorWithMSG(@"请登录");
            case WSFAPIManagerResponseStatusRequestError:
            return WSFResponseErrorWithMSG(@"参数错误");
            case WSFAPIManagerResponseStatusTypeServerCrash:
            return WSFResponseErrorWithMSG(@"服务器出错");
            case WSFAPIManagerResponseStatusTypeServerMessage:
            return WSFResponseErrorWithMSG(message?:@"未知信息");
        default:
            return WSFResponseErrorWithMSG(message?:@"未知错误");
    }
}

#pragma mark -
- (BOOL)beforePerformSuccessWithResponseModel:(WSFResponseModel *)responseModel {
    BOOL result = YES;
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:beforePerformSuccessWithResponseModel:)]) {
        result = [self.interceptor apiManager:self beforePerformSuccessWithResponseModel:responseModel];
    }
    return result;
}
- (void)afterPerformSuccessWithResponseModel:(WSFResponseModel *)responseModel {
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:afterPerformSuccessWithResponseModel:)]) {
        [self.interceptor apiManager:self afterPerformSuccessWithResponseModel:responseModel];
    }
}

- (BOOL)beforePerformFailWithResponseError:(WSFResponseError *)error {
    BOOL result = YES;
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:beforePerformFailWithResponseError:)]) {
        result = [self.interceptor apiManager:self beforePerformFailWithResponseError:error];
    }
    return result;
}
- (void)afterPerformFailWithResponseError:(WSFResponseError *)error {
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:afterPerformFailWithResponseError:)]) {
        [self.interceptor apiManager:self afterPerformFailWithResponseError:error];
    }
}

- (BOOL)shouldLoadRequestWithParams:(NSDictionary *)params {
    BOOL result = YES;
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:shouldLoadRequestWithParams:)]) {
        result = [self.interceptor apiManager:self shouldLoadRequestWithParams:params];
    }
    return result;
}

- (void)afterLoadRequestWithParams:(NSDictionary *)params {
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(apiManager:afterLoadRequestWithParams:)]) {
        [self.interceptor apiManager:self afterLoadRequestWithParams:params];
    }
}

- (void)afterPerformCancel {
    if (self != self.interceptor
        && [self.interceptor respondsToSelector:@selector(afterPerformCancel:)]) {
        [self.interceptor afterPerformCancel:self];
    }
}


#pragma mark - 校验器
// 这里不作实现，这样子类重写时，不需要调用super
- (BOOL)isResponseDataCorrect:(WSFResponseModel *)reponseModel {
    return YES;
}
@end

