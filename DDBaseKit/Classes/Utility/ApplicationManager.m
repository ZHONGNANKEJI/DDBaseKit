//
//  ApplicationManager.m
//  EHome
//
//  Created by Lifee on 2018/8/28.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "ApplicationManager.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

#define AppOnceToken @"AppOnceToken"
#define DontAllowDownloadWhenNoneWifi  @"dontAllowDownloadWhenNoneWifi"

@interface ApplicationManager()
@end

@implementation ApplicationManager

static ApplicationManager * _manager = nil ;
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
//        [self.linphone start_sipcore];
    }
    return self ;
}
- (UserInfo *)userInfo {
    
    if (!_userInfo) {
       UserInfo * info = [NSKeyedUnarchiver unarchiveObjectWithFile:usr_info_path()];
        if (info) {
            _userInfo = info ;
        }else{
            _userInfo = [UserInfo new];
        }
    }
    return _userInfo ;
}
- (YYCache *)yyCache {
    if (!_yyCache) {
        _yyCache = [YYCache cacheWithName:@"EHome"];
        _yyCache.diskCache.countLimit = 10;
    }
    return _yyCache ;
}

- (NSString *)wifiName
{
    NSString *wifiName = nil;
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil)
    {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil)
        {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            wifiName = [dict valueForKey:@"SSID"];
        }
    }
    return wifiName;
}
- (NSString *)ipAddress {
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE =4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len =sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP =@"";
    for (int i=0; i < ips.count; i++)    {
        if (ips.count >0){
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}
NSString * usr_info_path(void) {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.info"];
}

- (BOOL)appOnceUsed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:AppOnceToken];
}
- (void)setAppOnceUsed:(BOOL)appOnceUsed{
    [[NSUserDefaults standardUserDefaults] setBool:appOnceUsed forKey:AppOnceToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setDontAllowDownloadWhenNoneWifi:(BOOL)dontAllowDownloadWhenNoneWifi {
    [[NSUserDefaults standardUserDefaults] setBool:dontAllowDownloadWhenNoneWifi forKey:DontAllowDownloadWhenNoneWifi];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)dontAllowDownloadWhenNoneWifi {
    return [[NSUserDefaults standardUserDefaults] boolForKey:DontAllowDownloadWhenNoneWifi];
}

- (void)saveInfo:(UserInfo *)info{
    [NSKeyedArchiver archiveRootObject:info toFile:usr_info_path()];
}
- (NSString *)appVersion {
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
- (UIApplicationState)applicationState {
    return [UIApplication sharedApplication].applicationState ;
}
- (UIViewController *)keyVC {
    UIViewController * vc = [UIApplication sharedApplication].delegate.window.rootViewController ;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)vc ;
        UINavigationController * selvc = tabVC.selectedViewController ;
        if ([selvc isKindOfClass:[RTRootNavigationController class]]) {
            RTRootNavigationController * nav = (RTRootNavigationController *)selvc ;
            NSLog(@"当前控制器是####%@",nav.rt_topViewController);
            return nav.rt_visibleViewController ;
        }
        return selvc.topViewController;
    }else if ([vc isKindOfClass:[RTRootNavigationController class]]){
        RTRootNavigationController * nav = (RTRootNavigationController *)vc ;
        if ([nav.rt_visibleViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController * tabVC = (UITabBarController *)nav.rt_visibleViewController ;
            UINavigationController * selvc = tabVC.selectedViewController ;
            if ([selvc isKindOfClass:[RTRootNavigationController class]]) {
                RTRootNavigationController * nav = (RTRootNavigationController *)selvc ;
                NSLog(@"当前控制器是####%@",nav.rt_topViewController);
                return nav.rt_visibleViewController ;
            }
            return selvc.topViewController;
        }else if ([nav.rt_visibleViewController isKindOfClass:[UIViewController class]]){
            return nav.rt_visibleViewController ;
        }
        return nil ;
    }
    return nil ;
}
- (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow ;
}
- (UINavigationController *)keyNavigationController {
    UIViewController * vc = [UIApplication sharedApplication].delegate.window.rootViewController ;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)vc ;
        UINavigationController * selvc = tabVC.selectedViewController ;
        if ([selvc isKindOfClass:[RTRootNavigationController class]]) {
            RTRootNavigationController * nav = (RTRootNavigationController *)selvc ;
            return nav ;
        }
        return selvc;
    }else if ([vc isKindOfClass:[RTRootNavigationController class]]){
        RTRootNavigationController * nav = (RTRootNavigationController *)vc ;
        return nav ;
    }
    return nil ;
}
- (NSString *)timeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}
- (void)clearUserInfo{
    _userInfo = nil ;
    [[NSFileManager defaultManager] removeItemAtPath:usr_info_path() error:nil];
}

@end
