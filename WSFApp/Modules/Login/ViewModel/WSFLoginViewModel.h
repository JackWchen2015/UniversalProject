//
//  WSFLoginViewModel.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFBaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WSFLoginViewModel : WSFBaseViewModel
@property(nonatomic,assign)BOOL submitable;
@property(nonatomic,copy)NSString* emailStr;
@property(nonatomic,copy)NSString* pwdStr;
@end

NS_ASSUME_NONNULL_END
