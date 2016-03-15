//
//  AFNetWorkTool.h
//  HandMadeApp
//
//  Created by Kris on 15/11/7.
//  Copyright (c) 2015年 康雪菲. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 定义responseStyle枚举 */
typedef NS_ENUM(NSUInteger, responseStyle) {
    JSON,
    XML,
    Data
};
/** 定义requestStyle枚举 */
typedef NS_ENUM(NSUInteger, requestStyle) {
    RequestJSON,
    RequestString,
    RequestDefault
};
@interface AFNetWorkTool : NSObject
/**
 *  GET请求
 *
 *  @param url      URL网址
 *  @param body     参数
 *  @param style    responseStyle类型
 *  @param headFile 请求头
 *  @param success  请求成功
 *  @param failure  请求失败
 */
+ (void)getUrlString:(NSString *)url body:(id)body response:(responseStyle)style requestHeadFile:(NSDictionary *)headFile success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  POST请求
 *
 *  @param url       URL网址
 *  @param body      参数
 *  @param style     responseStyle类型
 *  @param bodyStyle body体类型
 *  @param headFile  请求头
 *  @param success   请求成功
 *  @param failure   请求失败
 */
+ (void)postUrlString:(NSString *)url body:(id)body response:(responseStyle)style bodyStyle:(requestStyle)bodyStyle requestHeadFile:(NSDictionary *)headFile success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
