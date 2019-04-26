//
//  RequestManager.h
//  EHome
//
//  Created by Lifee on 2018/7/14.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ReqManager [RequestManager manager]
@interface RequestManager : NSObject

+ (instancetype)manager ;
/**
 for Post Request

 @param s  url字符串
 @param dic 参数
 @param showIndicatior 是否显示菊花
 @param success 成功回调
 @param failure 失败回调
 */
- (void)POST_URLString:(NSString *)s
            parameters:(NSDictionary *)dic
        showIndicatior:(BOOL)showIndicatior
               success:(void(^)(id obj))success
               failure:(void(^)(NSError * error))failure;

/**
 for Get Request

 @param s url字符串
 @param dic 参数
 @param showIndicatior 是否显示菊花
 @param success 成功回调
 @param failure 失败回调
 */
-(void)GET_URLString:(NSString *)s
          parameters:(NSDictionary *)dic
      showIndicatior:(BOOL)showIndicatior
             success:(void (^)(id))success
             failure:(void (^)(NSError * error))failure ;


/**
 适用于非本服务器（不使用BaseURL的外部url）的Post请求

 @param s 完整的url
 @param showIndicatior showIndicatior 是否显示菊花
 @param success 成功回调
 @param failure 失败回调
 */
- (void)External_POST_URLString:(NSString *)s
                     parameters:(NSDictionary *)dic
                 showIndicatior:(BOOL)showIndicatior
                        success:(void (^)(id obj))success
                        failure:(void (^)(NSError * error))failure ;
- (void)External_POST_URLString:(NSString *)s
                   headerParams:(NSDictionary *)headerParams
                     parameters:(NSDictionary *)dic
                 showIndicatior:(BOOL)showIndicatior
                        success:(void (^)(id obj))success
                        failure:(void (^)(NSError * error))failure;

/**
 upload-images

 @param s url字符串
 @param images 图片数组
 @param dic 参数
 @param showIndicatior 是否显示菊花
 @param success 成功回调
 @param failure 失败回调
 */
- (void)uploadImagesURL:(NSString *)s
                 images:(NSArray *)images
                 params:(NSDictionary *)dic
         showIndicatior:(BOOL)showIndicatior
                success:(void(^)(id obj))success
                failure:(void(^)(NSError * error))failure ;
@end
