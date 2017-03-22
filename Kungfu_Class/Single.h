//
//  Single.h
//  Kungfu_Class
//
//  Created by 静静 on 24/02/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Single : NSObject
@property(nonatomic,copy)NSString *accountId;
@property(nonatomic,copy)NSString *physicalId;
@property(nonatomic, copy)NSString *doctorId;
@property(nonatomic, copy)NSString *hosipitalId;
@property(nonatomic, copy)NSString *hospitalName;
@property(nonatomic, copy)NSString *doctorName;


+(instancetype)shareSingle;

@end
