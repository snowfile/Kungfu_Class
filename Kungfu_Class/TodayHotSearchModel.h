//
//  TodayHotSearchModel.h
//  Kungfu_Class
//
//  Created by 静静 on 10/04/2017.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayHotSearchModel : NSObject

@property(nonatomic,assign)float cellWidth;
@property(nonatomic,copy)NSString *contentStr;
@property(nonatomic,copy)NSArray *tagId;
@property(nonatomic,strong)NSNumber *times;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)shareWithDict:(NSDictionary *)dict;
@end
