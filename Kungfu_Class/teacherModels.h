//
//  teacherModels.h
//  Kungfu_Class
//
//  Created by 静静 on 02/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface teacherModels : BaseModel
@property(nonatomic,strong)NSNumber *attendFlag;
@property(nonatomic,copy)NSString *departmentName;
@property(nonatomic,copy)NSString *description;
@property(nonatomic,copy)NSString *duties;
@property(nonatomic,copy)NSString *hospitalName;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *shortDesc;
@property(nonatomic,copy)NSString *specialty;

@property(nonatomic,copy)NSString *teachDuties;
@property(nonatomic,copy)NSString *teacherId;
@property(nonatomic,copy)NSString *teacherName;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *detailIcon;
@end
