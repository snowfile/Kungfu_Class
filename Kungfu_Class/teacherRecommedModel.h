//
//  teacherRecommedModel.h
//  Kungfu_Class
//
//  Created by 静静 on 09/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface teacherRecommedModel : BaseModel

@property(nonatomic,copy)NSNumber *attendFlag;

@property(nonatomic,copy)NSString *duties;

@property(nonatomic,copy)NSString *hospital;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *teacherId;

@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *speciality;

@property(nonatomic,copy)NSString *teachDutties;
@end
