//
//  AppointModel.h
//  Kungfu_Class
//
//  Created by 静静 on 18/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface AppointModel : BaseModel
@property(nonatomic,copy)NSString *reserveItems;
@property(nonatomic,strong)NSString *startTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,strong) NSNumber *reserveStatus;
@property (nonatomic,copy) NSString *reserveDate;
@property (nonatomic,strong)  NSNumber *isFirstTime;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *patientName;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *allergies;

@property (nonatomic,strong) NSNumber *gender;



@end
