//
//  UserRequestTool.m
//  WSFApp
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import "UserRequestTool.h"
#import "WSFHTTPSessionManager.h"

@implementation UserRequestTool

-(void)loginWithParameters:(NSDictionary *)parameters
             FinishedLogin:(void(^)(id responseObject))FinishedLogin
{

    [WSFHTTPSessionManager POST:_Login_URL parameters:nil progress:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

@end
