//
//  EHAletController.h
//  EHome
//
//  Created by Lifee on 2018/8/31.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AlertStyle) {
    ActionSheet = UIAlertControllerStyleActionSheet,
    Alert = UIAlertControllerStyleAlert
};

@interface EHAletController : NSObject
//index == 0 ~ acts.count-1
+ (void)alert:(NSString *)title
          msg:(NSString *)msg
        style:(AlertStyle)style
      actions:(NSArray *)acts
   operations:(void(^)(NSInteger index))op ;

+ (void)textfield_alert:(NSString *)title
                    msg:(NSString *)msg
            textfield_c:(NSInteger)c
           placeholders:(NSArray *)placeholders
                actions:(NSArray *)acts
             operations:(void (^)(NSInteger, NSArray *))op ;

@end
