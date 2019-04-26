//
//  ApplicationManager.h
//  EHome
//
//  Created by Lifee on 2018/8/28.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfo.h"
#import <YYCache/YYCache.h>
typedef NS_ENUM(NSInteger , NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};
#define AppManager [ApplicationManager manager]
#define User_Info  AppManager.userInfo
#define YY_CACHE   AppManager.yyCache
FOUNDATION_EXPORT  NSString * usr_info_path(void);
@interface ApplicationManager : BaseModel

/**
 app 是否第一次使用
 */
@property (nonatomic ,assign) BOOL  appOnceUsed;

@property (nonatomic ,assign) BOOL  isInBackground ;

/**
 缓存管理
 */
@property (nonatomic , strong) YYCache* yyCache;

@property (nonatomic ,copy ,readonly) NSString * wifiName ;
@property (nonatomic ,copy ,readonly) NSString * ipAddress ;
/**
 用户信息
 */
@property (nonatomic ,strong) UserInfo * userInfo ;
/**
 版本号
 */
@property (nonatomic ,copy ,readonly) NSString * appVersion ;
/**
 应用状态
 */
@property (nonatomic ,readonly) UIApplicationState applicationState ;
/**
 当前VC
 */
@property (nonatomic ,readonly ,strong) UIViewController * keyVC ;
/**
 当前导航控制器
 */
@property (nonatomic ,readonly ,strong) UINavigationController * keyNavigationController ;
@property (nonatomic ,strong ,readonly) UIWindow * keyWindow ;
/**
 当前时间戳
 */
@property (nonatomic ,readonly , copy) NSString * timeStamp ;

/**
 网络状态
 */
@property (nonatomic ,assign) NetworkReachabilityStatus netStatus ;
/**
 是否允许wifi环境下自动下载图片。
 */
@property (nonatomic ,assign) BOOL dontAllowDownloadWhenNoneWifi ;

@property (nonatomic ,copy) NSString * rsa_public_key ;
@property (nonatomic ,copy) NSString * baseURL ;

+ (instancetype)manager ;
- (void)saveInfo:(UserInfo *)info;
- (void)clearUserInfo ;
@end
