//
//  SearchModel.m
//  Kungfu_Class
//
//  Created by 静静 on 05/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
-(id)initWithDataDic:(NSDictionary *)data{
    self = [super initWithDataDic:data];
    _searchId = data[@"id"];
    return self;
}

@end
