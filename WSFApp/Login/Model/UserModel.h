//
//  UserModel.h
//
//  Created by USER on 2020/9/8.
//  Copyright © 2020 USER. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel

//用户ID
@property(nonatomic,copy)NSString *UserID;
//用户姓名
@property(nonatomic,copy)NSString *UserName;

@end
