//
//  RequestManager.m
//  EHome
//
//  Created by Lifee on 2018/7/14.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"
#import "RSAUtil.h"
#import "EHToast.h"
#import "ApplicationManager.h"
#import "DDBaseKit.h"
#import "NSString+Additions.h"
@implementation RequestManager{
    AFHTTPSessionManager * _sessionManager ;
}
static RequestManager * _manager = nil ;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL]init];
    });
    return _manager ;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self manager];
}

- (instancetype)init {
    if (self = [super init]) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 15 ;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
//        [_sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self ;
}
//排序并转为字符串
- (NSString*)convertToString:(NSDictionary*)dic{
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [dic allKeys].count; i ++) {
        NSString* str = [NSString stringWithFormat:@"%@=%@",[dic allKeys][i],[dic allValues][i]];
        [arr addObject:str];
    }
    NSStringCompareOptions comparisonOptions = NSLiteralSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range =NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray* sortedArr = [arr sortedArrayUsingComparator:sort];
    NSString* resultStr = sortedArr[0];
    for (NSInteger i = 1; i < sortedArr.count; i ++) {
        resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"&%@",sortedArr[i]]];
    }
    return resultStr;
}
- (NSDictionary*)RSAWithDic:(NSDictionary*)dic{
    NSString* signStr = [RSAUtil encryptString:[self convertToString:dic] publicKey:AppManager.rsa_public_key];
    NSMutableDictionary* bodyDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [bodyDic setValue:signStr forKey:@"sign"];
    return bodyDic;
}
- (void)POST_URLString:(NSString *)s
            parameters:(NSDictionary *)dic
        showIndicatior:(BOOL)showIndicatior
               success:(void(^)(id obj))success
               failure:(void(^)(NSError * error))failure{
    if (showIndicatior) {
        [EHToast showActivityView];
    }
    NSDictionary * params = [self dictionary_with_token:dic];
    NSDictionary* bodyDic = [self RSAWithDic:params];
    NSLog(@"--url:%@\n--bodyDic:%@",[AppManager.baseURL stringByAppendingString:s?:@""],bodyDic);

    [_sessionManager POST:[AppManager.baseURL stringByAppendingString:s?:@""] parameters:bodyDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            if (showIndicatior) {
                [EHToast dismissActivityView];
            }
            NSError* error = [[NSError alloc] initWithDomain:@"未知网络原因" code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];
            !failure?:failure(error);
            return ;
        }
        NSLog(@"%@",responseObject);
        if (![[responseObject objectForKey:@"status_code"] isEqualToString:@"00000"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"msg"] code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];
            if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"90000"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AccessTokenExpired" object:nil];
            }
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * errorTip = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil];
        !failure?:failure(errorTip);
        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    }] ;
    
}
- (void)External_POST_URLString:(NSString *)s parameters:(NSDictionary *)dic showIndicatior:(BOOL)showIndicatior success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSDictionary* bodyDic = [self RSAWithDic:dic];

    [self External_POST_URLString:s headerParams:nil parameters:bodyDic showIndicatior:showIndicatior success:success failure:failure];

}
- (void)External_POST_URLString:(NSString *)s headerParams:(NSDictionary *)headerParams parameters:(NSDictionary *)dic showIndicatior:(BOOL)showIndicatior success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (showIndicatior) {
        [EHToast showActivityView];
    }
    if (headerParams) {
        [headerParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    NSDictionary* bodyDic = [self RSAWithDic:dic];

    [_sessionManager POST:s parameters:bodyDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            if (showIndicatior) {
                [EHToast dismissActivityView];
            }
            NSError* error = [[NSError alloc] initWithDomain:@"未知网络原因" code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];

            !failure?:failure(error);
            return ;
        }
        NSLog(@"%@",responseObject);
        !success?:success(responseObject) ;
        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * errorTip = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil];
        !failure?:failure(errorTip);        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    }] ;
}
//
-(void)GET_URLString:(NSString *)s
          parameters:(NSDictionary *)dic
      showIndicatior:(BOOL)showIndicatior
             success:(void (^)(id))success
             failure:(void (^)(NSError * error))failure{
    
    if (showIndicatior) {
        [EHToast showActivityView];
    }
    [_sessionManager GET:[AppManager.baseURL stringByAppendingString:s?:@""] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            if (showIndicatior) {
                [EHToast dismissActivityView];
            }
            NSError* error = [[NSError alloc] initWithDomain:@"未知网络原因" code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];
            !failure?:failure(error);
            return ;
        }
        if (![[responseObject objectForKey:@"status_code"] isEqualToString:@"00000"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"msg"] code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];
            if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"90000"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:AccessTokenExpired object:nil];
            }
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * errorTip = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil];
        !failure?:failure(errorTip);
        if (showIndicatior) {
            [EHToast dismissActivityView];
        }
    }];
}

- (void)uploadImagesURL:(NSString *)s
                 images:(NSArray *)images
                 params:(NSDictionary *)dic
         showIndicatior:(BOOL)showIndicatior
                success:(void(^)(id obj))success
                failure:(void(^)(NSError * error))failure {
    
    [EHToast showActivityView];
    NSDictionary * params = [self dictionary_with_token:dic];
    NSDictionary* bodyDic = [self RSAWithDic:params];
    [_sessionManager POST:[AppManager.baseURL stringByAppendingString:s?:@""] parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i< images.count; i++) {
            UIImage *image = images[i];
            NSData *data = UIImageJPEGRepresentation(image, 0.15);
            [formData appendPartWithFileData:data name:@"imgFile" fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/*"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        NSLog(@"progress == %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            if (showIndicatior) {
                [EHToast dismissActivityView];
            }
            NSError* error = [[NSError alloc] initWithDomain:@"未知网络原因" code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];

            !failure?:failure(error);
            return ;
        }
        if (![[responseObject objectForKey:@"status_code"] isEqualToString:@"00000"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"msg"] code:[[responseObject objectForKey:@"status_code"] integerValue] userInfo:nil];
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        [EHToast dismissActivityView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [EHToast dismissActivityView];
        NSError * errorTip = [NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil];
        !failure?:failure(errorTip);
        
    }];
}
- (NSDictionary *)dictionary_with_token:(NSDictionary *)dic{
    
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString * token = User_Info.access_token;
    if (token != nil) {
        [paraDict setValue:token forKey:@"access_token"];
    }else {
        [paraDict setValue:@"" forKey:@"access_token"];
    }
    
    [paraDict setValue:AppManager.appVersion forKey:@"version"];
    [paraDict setValue:@"1" forKey:@"device_type"];
    [paraDict setValue:[NSString getNowTimeTimes] forKey:@"time_stamp"];
    return paraDict;
}
@end
