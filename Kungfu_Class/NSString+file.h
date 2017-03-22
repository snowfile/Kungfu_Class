//
//  NSString+file.h
//  Kungfu_Class
//
//  Created by 静静 on 1/3/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSArray+SHYUtil.h"
#import "util.h"

@interface NSString (file)
-(NSString *)filenameAppend:(NSString *)append;

-(NSString *)MD5;

-(NSString*)hidewithbegin:(NSInteger)begin andend:(NSInteger)end;

+(NSString*) createMd5Sign:(NSMutableDictionary*)dic;
+(NSString *)ret32bitString;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
//计算label的高度
-(CGFloat)calculateLabelHeightWithText:(NSString *)labelText LabelWidth:(CGFloat )width Font:(UIFont *)font;
//判断字符串的空值
+(NSString *)stringIsNull:(id)str;

//字符串转日期
- (NSDate *)StringTODate:(NSString *)sender;
//日期格式化转字符串
- (NSString *)DateTOString:(NSDate *)sender;
//计算两个日期间隔的天数
- (NSString *)calculateNowDate:(NSDate *)nowDate andValueDate:(NSDate *)ValueDate;


@end

