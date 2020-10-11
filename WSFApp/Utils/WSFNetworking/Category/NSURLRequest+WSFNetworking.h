//
//  NSURLRequest+WSFNetworking.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (WSFNetworking)
@property (nonatomic, copy) NSDictionary *wsf_requestParams;
@end

NS_ASSUME_NONNULL_END
