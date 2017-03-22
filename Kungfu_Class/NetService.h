//
//  NetService.h
//  Kungfu_Class
//
//  Created by 静静 on 12/19/16.
//  Copyright © 2016 秦静. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetService : NSObject

+ (NSURLSessionDataTask *)requestURL:(NSString *)urlstring
                          httpMethod:(NSString *)methord
                              params:(NSDictionary *)params
                          completion:(void(^)(id result,NSError *error))block;

//上传的网络请求
//+ (NSURLSessionUploadTask *)updateURL:(NSString *)urlstring
//                               params:(NSDictionary *)params
//                             fileData:(NSDictionary *)files
//                          complection:(void (^)(id, NSError *))block;

@end