//
//  WSFPageAPIManager.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFPageAPIManager.h"
const NSInteger kPageSizeNotFound = -1;
const NSInteger kPageIsLoading = -1;
const NSInteger kWSFPageAPIManagerDefaultPageSize = 10;

@interface WSFPageAPIManager()
@property (nonatomic, assign, readwrite) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, weak) id<WSFPageAPIManager> child;
@end
@implementation WSFPageAPIManager
#pragma mark - init
- (instancetype)init {
    return [self initWithPageSize:kWSFPageAPIManagerDefaultPageSize startPage:0];
}

- (instancetype)initWithPageSize:(NSInteger)pageSize {
    return [self initWithPageSize:pageSize startPage:0];
}

- (instancetype)initWithStartPage:(NSInteger)page {
    return [self initWithPageSize:kWSFPageAPIManagerDefaultPageSize startPage:page];
}

- (instancetype)initWithPageSize:(NSInteger)pageSize startPage:(NSInteger)page {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(WSFPageAPIManager)]) {
            self.child = (id <WSFPageAPIManager>)self;
        } else {
            @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ init failed",[self class]]
                                           reason:@"Subclass of WSFPageAPIManager should implement <WSFPageAPIManager>"
                                         userInfo:nil];
        }
        
        self.hasNextPage = YES;
        self.currentPage = page;
        self.pageSize = pageSize;
    }
    return self;
}

#pragma mark - logic

- (void)reset {
    [self resetToPage:0];
    
}

- (void)resetToPage:(NSInteger)page {
    self.currentPage = page;
    self.hasNextPage = YES;
}

- (NSInteger)loadNextPage {
    if (self.isLoading) {
        return kPageIsLoading;
    }
    return [super loadData];
}

- (NSInteger)loadNextPageWithoutCache {
    if (self.isLoading) {
        return kPageIsLoading;
    }
    return [super loadDataWithoutCache];
}

#pragma mark - override
- (NSInteger)loadData {
    return [self loadNextPage];
    //    @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@ load error",[self class]]
    //                                   reason:@"Don't call this Method. Call loadNextPage instead."
    //                                 userInfo:nil];
}

- (BOOL)beforePerformSuccessWithResponseModel:(WSFResponseModel *)responseModel {
    self.currentPage += 1;
    if (self.child.currentPageSize != kPageSizeNotFound
        && self.child.currentPageSize < self.pageSize) {
        self.hasNextPage = NO;
    }
    return [super beforePerformSuccessWithResponseModel:responseModel];
}

- (BOOL)beforePerformFailWithResponseError:(WSFResponseError *)error {
    if (self.currentPage > 0) {
        self.currentPage --;
    }
    return [super beforePerformFailWithResponseError:error];
}


#pragma mark - getter && setter
- (void)setPageSize:(NSInteger)pageSize {
    if (pageSize<=0) {
        NSLog(@"pageSize can't < 0");
        _pageSize = kWSFPageAPIManagerDefaultPageSize;
    } else {
        _pageSize = pageSize;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = MAX(0, currentPage);
}
@end

