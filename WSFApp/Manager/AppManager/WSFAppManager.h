//
//  WSFAppManager.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFAppManager : NSObject

SINGLETON_FOR_HEADER(WSFAppManager);
-(void)appStart;
@end

NS_ASSUME_NONNULL_END