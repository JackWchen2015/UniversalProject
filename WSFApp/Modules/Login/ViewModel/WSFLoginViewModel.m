//
//  WSFLoginViewModel.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFLoginViewModel.h"
#import "WSFLoginNetAPI.h"

@interface WSFLoginViewModel ()
@property(nonatomic,strong)WSFLoginNetAPI*  loginNetAPi;
@end
@implementation WSFLoginViewModel


-(void)setupRAC
{
    RAC(self,submitable)=[RACSignal combineLatest:@[RACObserve(self, emailStr),RACObserve(self, pwdStr)] reduce:^(NSString* emailStr,NSString* pwdStr){
        return @([self verifyEmail:emailStr]&&(pwdStr.length>=6&&pwdStr.length<=20));
    }];
    
    [self.networkingRAC.executionSignal subscribeNext:^(WSFResponseModel* x) {
            if (x.status==WSFResponseStatusSuccess) {
            };
    }];
}
     

-(BOOL)verifyEmail:(NSString*)email
{
    return true;
}
- (NSDictionary *)paramsForAPI:(WSFBaseAPIManager *)manager
{
    return @{
             @"email":_emailStr,
             @"passwd":[_pwdStr md5String]
             };
}
- (id<WSFNetworkingRACOperationProtocol>)networkingRAC
{
    return self.loginNetAPi;
}
-(WSFLoginNetAPI*)loginNetAPi
{
    if (!_loginNetAPi) {
        _loginNetAPi=[WSFLoginNetAPI new];
        _loginNetAPi.dataSource=self;
    }
    return _loginNetAPi;
}

@end
