//
//  WSFSignatureGenerator.h
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFSignatureGenerator : NSObject
+ (NSString *)signatureWithRequestPath:(NSString *)path params:(NSDictionary *)params extra:(NSString *)extra;
@end

NS_ASSUME_NONNULL_END
