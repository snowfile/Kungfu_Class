//
//  ClinicModel.h
//  Kungfu_Class
//
//  Created by 静静 on 21/03/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "BaseModel.h"

@interface ClinicModel : BaseModel

@property(nonatomic,copy)NSString *doctorId;
@property(nonatomic,copy)NSString *doctorName;
@property(nonatomic,copy)NSString *hospitalId;
@property(nonatomic,copy)NSString *hospitalName;
@property(nonatomic,copy)NSNumber *status;
@property(nonatomic,assign)BOOL   selected;

@end
