//
//  courseRecommedModel.h
//  Kungfu_Class
//
//  Created by 静静 on 09/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface courseRecommedModel : BaseModel

@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *courseId;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSNumber *orignPrice;
@property(nonatomic,copy)NSNumber *presentPrice;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *city;
@end
