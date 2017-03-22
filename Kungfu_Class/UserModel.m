//
//  UserModel.m
//  Kungfu_Class
//
//  Created by 静静 on 27/02/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@synthesize  userId;
@synthesize  userName;
@synthesize  userPhone;
@synthesize  imgURL;
@synthesize  accountId;
@synthesize  physicalId;
@synthesize  token;
@synthesize  gender;
@synthesize  birthday;
@synthesize  age;

+(instancetype)sharedInstance{
    static id shareUserInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareUserInfo = [[UserModel alloc]init];
    });
    return shareUserInfo;
}

+(void)setPhysicalInfo:(id)physicalinfo{

    physicalInfo = physicalinfo;
    
}
+(id)getPhysicalInfo{
    
    return physicalInfo;
}
@end
