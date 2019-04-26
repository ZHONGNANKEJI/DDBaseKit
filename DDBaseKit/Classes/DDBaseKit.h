//
//  GlobalMacro.h
//  EHome
//
//  Created by Lifee on 2018/7/14.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#ifndef DDBaseKit_h
#define DDBaseKit_h

//gloabal Data
#define SERVICE_NUMBER @"03748686998"
//fonts
#define font_10  [UIFont systemFontOfSize:10]
#define font_11  [UIFont systemFontOfSize:11]
#define font_12  [UIFont systemFontOfSize:12]
#define font_13  [UIFont systemFontOfSize:13]
#define font_14  [UIFont systemFontOfSize:14]
#define font_15  [UIFont systemFontOfSize:15]
#define font_16  [UIFont systemFontOfSize:16]
#define font_17  [UIFont systemFontOfSize:17]
#define font_18  [UIFont systemFontOfSize:18]
#define font_19  [UIFont systemFontOfSize:19]
#define font_20  [UIFont systemFontOfSize:20]

//devices
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NaviBarHeight (iPhoneX?88:64)
//methods
#define GET_COLOR_BY_LONG(colorHex)     ([UIColor colorWithRed:((colorHex & 0xFF0000) >> 16)/255.0\
                                            green:((colorHex & 0x00FF00) >> 8)/255.0 \
                                            blue:(colorHex & 0x0000FF)/255.0 alpha:1.0])
#define GET_COLOR_BY_RGB(r,g,b)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define LINE_COLOR GET_COLOR_BY_RGB(230,230,230)
#define BLUE_COLOR GET_COLOR_BY_LONG(0x3f86ff)
//log
#if DEBUG
#define NSLog(...) NSLog(@"%s,%s 第%d行 \n %@\n\n",__FILE__,__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//notifications
#define AccessTokenExpired  @"AccessTokenExpired"
#define RequestMainHouse    @"RequestMainHouse"
#define Local_Push_Call     @"localCall"

//YYCache
#define Cache_Search_History     @"search_history"
//APPKey &APPID

#define GW_APPID @"4bffc8189a2f47be90141ce9dd7c5a2c"
#define GW_APPTOKEN @"c24e973196def53ad91000873eb56a66e8da0b17f7f6c625ca5bc100a79059b8"
#define RSA_PUBLICKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSUmOXyQmYYSnZacp0btvAZCOvCNPtzixAp7eJmzmAG4mgy/VgrY/s1BDLh9qTNHIRWXepUtwMrf1kYul/A45qE/2oxIbeeq4238YDWQ7ModOVXR9ytEHsT0jpCFvoYfYXYZnnoWRrLIBylQeXzqxbLDxxBxGCs4AjoRKh5S7nNQIDAQAB"
//weakify & strongify  这个宏定义在RAC中已经定义过了。
//#ifndef weakify
//#if DEBUG
//#if __has_feature(objc_arc)
//#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
//#else
//#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
//#endif
//#else
//#if __has_feature(objc_arc)
//#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
//#else
//#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
//#endif
//#endif
//#endif
//
//#ifndef strongify
//#if DEBUG
//#if __has_feature(objc_arc)
//#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
//#else
//#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
//#endif
//#else
//#if __has_feature(objc_arc)
//#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
//#else
//#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
//#endif
//#endif
//#endif



#endif /* GlobalMacro_h */
