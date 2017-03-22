//
//  NetService.m
//  Kungfu_Class
//
//  Created by 静静 on 12/19/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import "NetService.h"
#import "UserModel.h"

@implementation NetService

//+ (NSURLSessionDataTask *)requestURL:(NSString *)urlstring
//                          httpMethod:(NSString *)methord
//                              params:(NSDictionary *)params
//                          completion:(void(^)(id result,NSError *error))block{
//
//    //1.拼接url
//    //1.拼接URL
//    NSString *url;
//    
//    if ([urlstring containsString:BASE_URL]) {
//        //聊天
//        url = urlstring;
//    }else{
//        url = [BASE_URL stringByAppendingString:urlstring];
//    }
+ (NSURLSessionDataTask *)requestURL:(NSString *)urlstring
                          httpMethod:(NSString *)method
                              params:(NSDictionary *)params
                          completion:(void(^)(id result,NSError *error))block {
    //1.拼接url
    //1.拼接URL
    NSString *url = [BASE_URL stringByAppendingString:urlstring];
    
    NSMutableDictionary *mutableParmas = params.mutableCopy;
    if (mutableParmas == nil) {
        mutableParmas = @{}.mutableCopy;
    }
    //创建session对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    UserModel *usermodel = [UserModel sharedInstance];
    [ manager.requestSerializer setValue:[NSString stringIsNull:usermodel.token] forHTTPHeaderField:@"Authorization"];
    //判断请求方式
    if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        NSURLSessionDataTask *task = [manager GET:url parameters:mutableParmas progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
        return task;
    }
    else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame) {
        NSURLSessionDataTask *task = [manager POST:url parameters:mutableParmas progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
        return  task;
    }
    else if ([method caseInsensitiveCompare:@"PUT"] == NSOrderedSame) {
        NSURLSessionDataTask *task = [manager PUT:url parameters:mutableParmas success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
        return task;
    }
    
    return nil;
}

@end
