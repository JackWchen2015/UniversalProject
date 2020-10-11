//
//  WSFPageAPIManager.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFBaseAPIManager.h"
NS_ASSUME_NONNULL_BEGIN

extern const NSInteger kPageSizeNotFound;
extern const NSInteger kPageIsLoading;

@protocol WSFPageAPIManager<WSFAPIManagerProtocol>
@required
- (NSInteger)currentPageSize;// 从未加载过时，应返回kPageSizeNotFound
@end

@interface WSFPageAPIManager : WSFBaseAPIManager
@property (nonatomic, assign, readonly) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSInteger currentPage;
@property (nonatomic, assign, readonly) BOOL hasNextPage;
// 重置currentPage
- (void)reset;
- (void)resetToPage:(NSInteger)page;

- (NSInteger)loadNextPage; // 如果正在加载则返回 kPageIsLoading，否则则返回requestId
- (NSInteger)loadNextPageWithoutCache;


- (instancetype)initWithPageSize:(NSInteger)pageSize;
- (instancetype)initWithPageSize:(NSInteger)pageSize startPage:(NSInteger)page NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
