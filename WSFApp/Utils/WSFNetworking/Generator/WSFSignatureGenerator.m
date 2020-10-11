//
//  WSFSignatureGenerator.m
//  WSFApp
//
//  Created by jack on 2020/9/12.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFSignatureGenerator.h"
#import "Foundation+WSFNetworking.h"
@implementation WSFSignatureGenerator
+ (NSString *)signatureWithRequestPath:(NSString *)path params:(NSDictionary *)params extra:(NSString *)extra {
    return [[NSString stringWithFormat:@"%@%@%@",path, [params wsf_md5], extra] wsf_md5];
}

@end
