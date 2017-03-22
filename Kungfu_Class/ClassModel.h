//
//  ClassModel.h
//  Kungfu_Class
//
//  Created by 静静 on 03/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface ClassModel : BaseModel

@property(nonatomic,copy)NSString *sponsor;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *courseType;
@property(nonatomic,copy)NSString *coursesId;
@property(nonatomic,copy)NSString *coursesName;
//@property(nonatomic,copy)NSString *description;
@property(nonatomic,copy)NSString *detailIcon;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSNumber *isBooked;
@property(nonatomic,copy)NSString *listIcon;
@property(nonatomic,copy)NSString *originalPrice;
@property(nonatomic,copy)NSNumber *presentPrice;
@property(nonatomic,copy)NSString *shortDesc;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *teacherId;
@property(nonatomic,copy)NSString *teacherName;
@property(nonatomic,copy)NSString *teacherUserId;

@end
