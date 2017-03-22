//
//  WXBaseModel.h
//  MTWeibo
//  所有对象实体的基类

//  Created by wei.chen on 11-9-22.
// 
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding>{

}

-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)descriptioning;
- (NSData*)getArchivedData;



@end
