//
//  NSString+Additions.h
//  EHome
//
//  Created by Lifee on 2018/9/7.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT  CGSize  stringSize(NSString * s ,CGSize sizeRange , CGFloat fontSize);

@interface NSString (Additions)

/**
 是否是邮件

 @return YES:是email ，NO 不是email
 */
- (BOOL)is_email ;

/**
 是否是手机号码

 @return YES：是手机号码 ，NO 不是手机号
 */
- (BOOL)is_phone_number ;

/**
 是否是null ，注意，空字符串不是nil。

 @return YES：不是空， NO：是null
 */
- (BOOL)is_not_null ;

/**
 是否是空字符串

 @return YES，是空字符串，NO 不是空字符串
 */
- (BOOL)is_blank ;

/**
 是否包含字符串
 */
//- (BOOL)containsString:(NSString *)string;
/**
 是否是null 或者是 空字符串 。等同于 is_not_null + is_blank 。

 @return YES：不是空字符串 ，NO ：是空
 */
- (BOOL)is_not_empty ;

/**
 去掉首位空格的字符串和换行的
 */
- (NSString *)stringByTrim ;

/**
 md5 字符串
 */
- (NSString *)md5String ;

/**
 base64字符串
 */
- (NSString *)base64EncodedString ;

/**
 获取字符串中的数字比如@"我是23测试456"， 只能分离23.，已经可以满足业务需求
 */
- (NSString *)numberSet ;

/**
 获取字节数
 */
- (NSInteger)getCharLength;
+ (NSString *)getNowTimeTimes;
- (NSString *)SHA256;

/**
 将X栋X单元X层X房 转为 X栋XXX
 */
- (NSString*)houseNameHandle;
@end
