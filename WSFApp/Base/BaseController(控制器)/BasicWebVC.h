//
//  BasicWebVC.h
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasicWebVC : BasicMainVC

@property(nonatomic,assign)CGRect viewFrame;

- (void)reloadForGetWebView:(NSString *)htmlStr;
- (void)reloadForPostWebView:(NSString *)htmlStr parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
