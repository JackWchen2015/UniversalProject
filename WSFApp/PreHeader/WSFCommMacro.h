//
//  WSFCommMacro.h
//  WSFApp
//
//  Created by jack on 2020/9/11.
//  Copyright © 2020 USER. All rights reserved.
//

#ifndef WSFCommMacro_h
#define WSFCommMacro_h

#import <objc/runtime.h>

//存放业务相关的宏定义

#define DEFAULT_MMKV  [MMKV defaultMMKV]
#define KUserToken  [DEFAULT_MMKV getStringForKey:kUserDefauToken]




#define KNotificationLoginStateChange @"loginStateChange"


#endif /* WSFCommMacro_h */
