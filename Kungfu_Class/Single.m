//
//  Single.m
//  Kungfu_Class
//
//  Created by 静静 on 24/02/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "Single.h"

@implementation Single
@synthesize accountId;

@synthesize  physicalId;
@synthesize  doctorId;
@synthesize  hosipitalId;
@synthesize  hospitalName;
@synthesize  doctorName;


+(instancetype)shareSingle{
    static id shareSingle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSingle = [[Single alloc] init];
    });
    return shareSingle;
}
@end
