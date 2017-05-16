//
//  NSString+Regex.h
//  DentalDoc
//
//  Created by pengpeng on 2016/11/10.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

//是否是手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//MD5加密
- (NSString *)MD5;

//判断是否为空
+ (NSString *)stringIsNull:(id)str;

//根据日期计算年龄
+ (NSString *)ageWithDateOfBirth:(NSDate *)date;

- (CGFloat)calculateLabelHeightWithText:(NSString *)labelText LabelWidth:(CGFloat)width Font:(UIFont *)font;
@end
