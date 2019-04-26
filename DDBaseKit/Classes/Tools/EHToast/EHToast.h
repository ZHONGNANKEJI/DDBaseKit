//
//  EHToast.h
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_DISPLAY_DURATION 2.0f
@interface EHToast : NSObject

+ (void)toast:(NSString *) text_;
+ (void)toast:(NSString *) text_ duration:(CGFloat)duration_;

// 只使用SVProgressHUD 实现
//
//+ (void)toast:(NSString *) text_ topOffset:(CGFloat) topOffset_;
//+ (void)toast:(NSString *) text_ topOffset:(CGFloat) topOffset duration:(CGFloat) duration_;
//
//+ (void)toast:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_;
//+ (void)toast:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_ duration:(CGFloat) duration_;

+ (void)showActivityView ;
+ (void)dismissActivityView ;

@end
