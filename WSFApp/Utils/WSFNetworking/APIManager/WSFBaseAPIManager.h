//
//  WSFBaseAPIManager.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class WSFBaseAPIManager;
extern NSString * const WSFAPIBaseManagerRequestId;

typedef NS_ENUM (NSUInteger, WSFRequestType){
    WSFRequestTypeGet,
    WSFRequestTypePost,
    WSFRequestTypePatch
};

typedef NS_ENUM (NSInteger, WSFAPIManagerResponseStatus){
    WSFAPIManagerResponseStatusDefault = -1,             //没有产生过API请求，默认状态。
    WSFAPIManagerResponseStatusTimeout = 101,            //请求超时
    WSFAPIManagerResponseStatusNoNetwork = 102,          //网络不通
    WSFAPIManagerResponseStatusSuccess = 0,            //API请求成功且返回数据正确
    WSFAPIManagerResponseStatusParsingError = 201,       //API请求成功但返回数据不正确
    WSFAPIManagerResponseStatusTokenExpired = 300,       //token过期
    WSFAPIManagerResponseStatusNeedLogin = 301,          //认证信息无效
    WSFAPIManagerResponseStatusRequestError = 400,       //请求出错，参数或方法错误
    WSFAPIManagerResponseStatusTypeServerCrash = 500,    //服务器出错
    WSFAPIManagerResponseStatusTypeServerMessage = 600,  //服务器自定义消息
};

// For transfer data  数据转换
@protocol WSFAPIManagerDataReformer <NSObject>
@required
- (id)apiManager:(WSFBaseAPIManager *)manager reformData:(NSDictionary *)data;
@end

@protocol WSFAPIManagerProtocol <NSObject>
@required
- (NSString *)path;
- (NSString *)apiVersion;
- (BOOL)isAuth;

@optional
- (WSFRequestType)requestType;
- (BOOL)isResponseJSONable;
- (BOOL)isRequestUsingJSON;

- (BOOL)shouldCache;
- (NSInteger)cacheExpirationTime; // 返回0或者负数则永不过期
@end

@protocol WSFAPIManagerDataSource <NSObject>
@required
- (NSDictionary *)paramsForAPI:(WSFBaseAPIManager *)manager;
@end

@protocol WSFAPIManagerDelegate <NSObject>
@required
- (void)apiManagerLoadDataSuccess:(WSFBaseAPIManager *)apiManager;
- (void)apiManager:(WSFBaseAPIManager *)apiManager loadDataFail:(WSFResponseError *)error;

@optional
- (void)apiManagerLoadDidCancel:(WSFBaseAPIManager *)apiManager;
@end

@protocol WSFAPIManagerInterceptor <NSObject>
@optional
- (BOOL)apiManager:(WSFBaseAPIManager *)manager beforePerformSuccessWithResponseModel:(WSFResponseModel *)responsemodel;
- (void)apiManager:(WSFBaseAPIManager *)manager afterPerformSuccessWithResponseModel:(WSFResponseModel *)responseModel;

- (BOOL)apiManager:(WSFBaseAPIManager *)manager beforePerformFailWithResponseError:(WSFResponseError *)error;
- (void)apiManager:(WSFBaseAPIManager *)manager afterPerformFailWithResponseError:(WSFResponseError *)error;

- (void)afterPerformCancel:(WSFBaseAPIManager *)manager;

- (BOOL)apiManager:(WSFBaseAPIManager *)manager shouldLoadRequestWithParams:(NSDictionary *)params;
- (void)apiManager:(WSFBaseAPIManager *)manager afterLoadRequestWithParams:(NSDictionary *)params;
@end

@interface WSFBaseAPIManager : NSObject
@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, readonly) dispatch_semaphore_t continueMutex;

@property (nonatomic, weak) id<WSFAPIManagerDataSource> dataSource;
@property (nonatomic, weak) id<WSFAPIManagerDelegate> delegate;
@property (nonatomic, weak) id<WSFAPIManagerInterceptor> interceptor;

// addDependency和removeDependency仅在loadData前执行有效
- (void)addDependency:(WSFBaseAPIManager *)apiManager;
- (void)removeDependency:(WSFBaseAPIManager *)apiManager;

- (NSInteger)loadData;
- (NSInteger)loadDataWithoutCache;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

- (BOOL)isReachable;

- (id)fetchData;
- (id)fetchDataWithReformer:(id<WSFAPIManagerDataReformer>)reformer;
- (id)fetchDataFromModel:(Class)clazz; //默认只实现单个model，且对应model字段为data，否则需重写这个方法

- (NSDictionary *)reformParams:(NSDictionary *)params;

// default
- (NSString *)host;
- (WSFRequestType)requestType;   //default is YLRequestTypePost;
- (BOOL)isResponseJSONable;     //default is YES;
- (BOOL)isRequestUsingJSON;     //default is YES;

- (NSInteger)cacheExpirationTime; // 返回0或者负数则永不过期

#pragma mark - 拦截器
// 用于子类需要监听相关事件，覆盖时需调用super对应方法
- (BOOL)beforePerformSuccessWithResponseModel:(WSFResponseModel *)responseModel;
- (void)afterPerformSuccessWithResponseModel:(WSFResponseModel *)responseModel;

- (BOOL)beforePerformFailWithResponseError:(WSFResponseError *)error;
- (void)afterPerformFailWithResponseError:(WSFResponseError *)error;

- (void)afterPerformCancel;

- (BOOL)shouldLoadRequestWithParams:(NSDictionary *)params;
- (void)afterLoadRequestWithParams:(NSDictionary *)params;

#pragma mark - 校验
// 需要校验则重写此方法
- (BOOL)isResponseDataCorrect:(WSFResponseModel *)reponseModel;
@end

NS_ASSUME_NONNULL_END
