//
//  LocationManager.m
//  EHome
//
//  Created by cydida on 2018/12/18.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "LocationManager.h"
#import "EHAletController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic , strong) CLLocationManager* CLManager;

@end
@implementation LocationManager
static  LocationManager* _manager = nil ;

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
- (instancetype)init{
    if (self = [super init]) {
        self.locationCity = @"未知";
        self.currentCity = @"禹州";
        self.CLManager = [[CLLocationManager alloc] init];
        self.CLManager.delegate = self;
        if ([CLLocationManager locationServicesEnabled]) {
            //            self.CLManager.distanceFilter=kCLDistanceFilterNone;
            //            self.CLManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
            [self.CLManager requestWhenInUseAuthorization];
            [self.CLManager startUpdatingLocation];
        }else
        {
            [EHAletController alert:@"提示" msg:@"开启定位服务" style:Alert actions:@[@"取消",@"设置"] operations:^(NSInteger index) {
                if (index == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationLaunchOptionsLocationKey]];
                }
            }];
        };
    }
    return self;
}
- (void)startLocation{
    [self.CLManager startUpdatingLocation];
}
#pragma mark --
#pragma mark -- CLLocationManagerDelegate --
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation* location = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark* obj in placemarks) {
            if ([obj.locality containsString:@"市"]) {
                self.locationCity = [obj.locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }else{
                self.locationCity = obj.locality;
            }
        }
        if (![self.locationCity isEqualToString:@"未知"]) {
            //解决定位延迟  首页不显示定位
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                self.currentCity = self.locationCity;
            });
        }
        [self.CLManager stopUpdatingLocation];
    }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if(error.code == kCLErrorLocationUnknown) {
        NSLog(@"无法检索位置");
    }
    else if(error.code == kCLErrorNetwork) {
        NSLog(@"网络问题");
    }
    else if(error.code == kCLErrorDenied) {
        NSLog(@"定位权限的问题");
        [self.CLManager stopUpdatingLocation];
    }
    
}
@end
