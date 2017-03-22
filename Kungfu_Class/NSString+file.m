//
//  NSString+file.m
//  Kungfu_Class
//
//  Created by 静静 on 1/3/17.
//  Copyright © 2017 秦静. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)

#pragma mark - 生成新的文件名
-(NSString *)filenameAppend:(NSString *)append{
    // 1.获取没有拓展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    
    // 2.拼接append
    filename = [filename stringByAppendingString:append];
    
    // 3.拼接拓展名
    NSString *extension = [self pathExtension];
    
    // 4.生成新的文件名
    return [filename stringByAppendingPathExtension:extension];
}

#pragma mark - 创建package签名
+(NSString*) createMd5Sign:(NSMutableDictionary*)dic
{
    //    NSLog(@"%@",dic);
    NSArray *arr = [dic allKeys];
    
    // 排序
    NSArray *sortArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    
    NSString *resultStr = @"";
    
    // 拼接
    for (int i = 0; i < sortArr.count; i++) {
        
        
        NSString *key   = sortArr[i];  id value = dic[key];
        if ([key isEqualToString:@"productList"]) {
            NSArray *array = (NSArray *)value;
            
            for (int i =0; i<array.count; i++) {
                NSDictionary *dic = [array objectAtIndexCheck:i];
                if (dic[@"currentPrice"]!=nil) {
                    if ([dic[@"unitNo"] isKindOfClass:[NSNull class]]) {
                        NSString *str1 = [NSString stringWithFormat:@"{\"currentPrice\":%@,\"originalPrice\":%@,\"productId\":%@,\"productNumber\":%@,\"unitFactor\":%@,\"unitNo\":%@,\"attributeList\":[{\"attributeId\":%@,\"valueId\":\"%@\"}]}",dic[@"currentPrice"],dic[@"originalPrice"],dic[@"productId"],dic[@"productNumber"],dic[@"unitFactor"],@"null",[dic[@"attributeList"] objectAtIndexCheck:0][@"attributeId"],[dic[@"attributeList"] objectAtIndexCheck:0][@"valueId"]];
                        if (array.count==1) {
                            value = [NSString stringWithFormat:@"[%@]",str1];
                        }else {
                            if (i== 0) {
                                value = [NSString stringWithFormat:@"[%@",str1];
                            }else if (i == array.count-1) {
                                value = [NSString stringWithFormat:@"%@,%@]",value,str1];
                            }else {
                                value = [NSString stringWithFormat:@"%@,%@",value,str1];
                            }
                        }
                    }else {
                        NSString *str1 = [NSString stringWithFormat:@"{\"currentPrice\":%@,\"originalPrice\":%@,\"productId\":%@,\"productNumber\":%@,\"unitFactor\":%@,\"unitNo\":%@,\"attributeList\":[{\"attributeId\":%@,\"valueId\":\"%@\"}]}",dic[@"currentPrice"],dic[@"originalPrice"],dic[@"productId"],dic[@"productNumber"],dic[@"unitFactor"],dic[@"unitNo"],[dic[@"attributeList"] objectAtIndexCheck:0][@"attributeId"],[dic[@"attributeList"] objectAtIndexCheck:0][@"valueId"]];
                        if (array.count==1) {
                            value = [NSString stringWithFormat:@"[%@]",str1];
                        }else {
                            if (i== 0) {
                                value = [NSString stringWithFormat:@"[%@",str1];
                            }else if (i == array.count-1) {
                                value = [NSString stringWithFormat:@"%@,%@]",value,str1];
                            }else {
                                value = [NSString stringWithFormat:@"%@,%@",value,str1];
                            }
                        }
                    }
                    
                    
                }else {
                    NSString *str1 = [NSString stringWithFormat:@"{\"productId\":%@,\"productNumber\":%@,\"attributeList\":[{\"attributeId\":%@,\"valueId\":\"%@\"}]}",dic[@"productId"],dic[@"productNumber"],[dic[@"attributeList"] objectAtIndexCheck:0][@"attributeId"],[dic[@"attributeList"] objectAtIndexCheck:0][@"valueId"]];
                    
                    if (array.count==1) {
                        value = [NSString stringWithFormat:@"[%@]",str1];
                    }else {
                        if (i== 0) {
                            value = [NSString stringWithFormat:@"[%@",str1];
                        }else if (i == array.count-1) {
                            value = [NSString stringWithFormat:@"%@,%@]",value,str1];
                        }else {
                            value = [NSString stringWithFormat:@"%@,%@",value,str1];
                        }
                    }
                }
                
            }
        }
        if ([key isEqualToString:@"payInfo"]) {
            NSDictionary *dic = (NSDictionary *)value;
            NSString *str = [NSString stringWithFormat:@"{\"payId\":%@,\"flag\":%@,\"flagPrice\":%@,\"totalPrice\":%@}",dic[@"payId"],dic[@"flag"],dic[@"flagPrice"],dic[@"totalPrice"]];
            value = str;
        }
        NSString *temStr = [NSString stringWithFormat:@"%@=%@", key, value];
        
        if (i != sortArr.count - 1) {
            
            
            
            temStr = [temStr stringByAppendingString:@"&"];
        }
        
        resultStr = [resultStr stringByAppendingString:temStr];
    }
    
    // 转大写
    resultStr = [resultStr uppercaseString];
    
    // 得 MD5 值
    const char *str = [resultStr UTF8String];
    
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), r);
    
    NSString *md5_str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    // md5 转大写
    NSString *s = [md5_str uppercaseString];
    
    return s;
}
#pragma mark -MD5
-(NSString*)MD5{
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
-(NSString*)hidewithbegin:(NSInteger)begin andend:(NSInteger)end{
    
    NSString *str=[NSMutableString string];
    NSString *temp = nil;
    int j=0;
    for(int i =0; i < [self length]; i++)
    {
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        if (i>=begin&&i<(self.length-end)) {
            
            if (j%4==0) {
                temp=@" *";
            }
            else
                temp=@"*";
            j++;
        }
        str=[str stringByAppendingString:temp];
    }
    return str;
}

#pragma -mark 生成32位随机码
+(NSString *)ret32bitString

{
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

#pragma -mark  正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma -mark 正则匹配用户密码6-18位数字或字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
#pragma -mark 正则匹配中文
+ (BOOL)checkChinese:(NSString *)chineseStr{
    
    NSString *pattern = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:chineseStr];
    
    return isMatch;
}

#pragma mark - 字符串的长度
- (CGSize )sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
#pragma -mark 计算label的高度

-(CGFloat)calculateLabelHeightWithText:(NSString *)labelText LabelWidth:(CGFloat)width Font:(UIFont *)font{
    
    CGFloat height=[labelText boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

#pragma mark - 判断字符串空值
+(NSString *)stringIsNull:(id )str
{
    if ([str isKindOfClass:[NSNull class]]||str == nil||[str isEqualToString:@"null"]||[str isEqualToString:@"<null>"]) {
        return @" ";
    }
    else
    {
        return (NSString *)str;
    }
}
#pragma -mark字符串转日期
- (NSDate *)StringTODate:(NSString *)sender
{
    
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:GTMzone];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}
#pragma -mark日期格式化转字符串
- (NSString *)DateTOString:(NSDate *)sender
{
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:GTMzone];
    
    //设置显示类型
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * DateStr = [dateFormatter stringFromDate:sender]; // date转换成为字符串
    return DateStr;
    
}
#pragma -mark计算两个日期间隔的天数
- (NSString *)calculateNowDate:(NSDate *)nowDate andValueDate:(NSDate *)ValueDate{
    
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:GTMzone];
    
    //计算两个中间差值(秒)
    NSTimeInterval time = [ValueDate timeIntervalSinceDate:nowDate];
    
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时
    NSString *dateValue = [NSString stringWithFormat:@"%i",days];
    
    return dateValue;
    
}

@end
