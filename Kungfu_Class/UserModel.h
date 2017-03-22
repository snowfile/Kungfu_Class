//
//  UserModel.h
//  Kungfu_Class
//
//  Created by 静静 on 27/02/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <Foundation/Foundation.h>

static id physicalInfo = nil;

@interface UserModel : NSObject

@property(nonatomic ,copy)NSString * userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userPhone;
@property(nonatomic, copy)NSString *imgURL;
@property(nonatomic,copy)NSString *accountId;
@property(nonatomic, copy)NSString *physicalId;
@property(nonatomic, copy)NSString *token;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *birthday;
@property(nonatomic, copy)NSString *age;


+(instancetype)sharedInstance;

+(void)setPhysicalInfo:(id)physicalInfo;
+(id)getPhysicalInfo;
@end
