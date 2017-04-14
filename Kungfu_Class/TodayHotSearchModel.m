//
//  TodayHotSearchModel.m
//  Kungfu_Class
//
//  Created by 静静 on 10/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "TodayHotSearchModel.h"

@implementation TodayHotSearchModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _contentStr = dict[@"tag"];
        UIFont *font = [UIFont systemFontOfSize:14];
        
        CGSize size = [_contentStr sizeWithAttributes:@{NSFontAttributeName:font}];
        
        _cellWidth = size.width+47;
        _tagId = dict[@"tagId"];
        _times = dict[@"tagId"];
    }
    return self;
}
+(instancetype)shareWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];

}
@end
