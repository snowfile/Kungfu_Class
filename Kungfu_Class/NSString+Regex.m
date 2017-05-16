//
//  NSString+Regex.m
//  DentalDoc
//
//  Created by pengpeng on 2016/11/10.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import "NSString+Regex.h"
#import <CommonCrypto/CommonDigest.h>
#import "Util.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (Regex)


+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *mobileStr = @"^((13[0-9])|(15[^4,\\D])|(14[5,7])|(17[0-9])|(18[^4,\\D]))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileStr];
    return [regextestmobile evaluateWithObject:mobileNum];
}


- (NSString*)MD5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)stringIsNull:(id )str
{
    if ([str isKindOfClass:[NSNull class]]||str == nil||[str isEqualToString:@"null"]||[str isEqualToString:@"<null>"] || [str isEqualToString:@""]) {
        return @"";
    }
    else {
        return [NSString stringWithFormat:@"%@",str];
    }
}

+ (NSString *)ageWithDateOfBirth:(NSDate *)date {
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return [NSString stringWithFormat:@"%ld",iAge];
}


-(CGFloat)calculateLabelHeightWithText:(NSString *)labelText LabelWidth:(CGFloat)width Font:(UIFont *)font {
    CGFloat height=[labelText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}
@end
