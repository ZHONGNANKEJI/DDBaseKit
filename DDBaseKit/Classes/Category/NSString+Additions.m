//
//  NSString+Additions.m
//  EHome
//
//  Created by Lifee on 2018/9/7.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+Additions.h"
@implementation NSString (Additions)
CGSize  stringSize(NSString * s ,CGSize sizeRange , CGFloat fontSize) {
    if (!s) {
        return CGSizeZero ;
    }
    return [s boundingRectWithSize:sizeRange options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size ;
}
- (BOOL)is_email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)is_phone_number {
    
    NSString *zhengze = @"^[1][34578]\\d{9}";
    NSPredicate *pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zhengze];
    BOOL isMatch = [pred4 evaluateWithObject:self];
    if (isMatch) {
        return YES;
    }
    return NO;
}
- (BOOL)is_not_null {
    //能调用此方法，改字符串就不是nil ，只需要判断字符串是不是以下类型的字符串。
    NSArray * nullObjs = @[@"NIL" ,@"Nil" ,@"nil",@"NULL" ,@"Null",@"null",@"(NULL)",@"(Null)",@"(null)",@"<NULL>",@"<Null>",@"<null>"];
    return ![nullObjs containsObject:self];
}
- (BOOL)is_blank {
    
    NSString *newStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newStr isEqualToString:@""]) {
        return YES ;
    }
    return NO ;
}
- (BOOL)is_not_empty {
    NSArray * nullObjs = @[@"NIL" ,@"Nil" ,@"nil",@"NULL" ,@"Null",@"null",@"(NULL)",@"(Null)",@"(null)",@"<NULL>",@"<Null>",@"<null>"];
    if ([nullObjs containsObject:self]){
        return NO ;
    }
    NSString *newStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newStr isEqualToString:@""]) {
        return NO;
    }
    return YES ;
}
//- (BOOL)containsString:(NSString *)string {
//    if (string == nil) return NO;
//    return [self rangeOfString:string].location != NSNotFound;
//}
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
- (NSString *)md5String {
    
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}
- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}
- (NSString *)numberSet {
    NSCharacterSet *numberset = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[self stringByTrimmingCharactersInSet:numberset];
}
- (NSString*)houseNameHandle{
    NSCharacterSet *numberset = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSMutableArray* temp = [[NSMutableArray alloc] initWithArray:[self componentsSeparatedByCharactersInSet:numberset]];
    [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@""]) {
            [temp removeObject:obj];
        }
    }];
    return [temp componentsJoinedByString:@"·"];
}
- (NSInteger)getCharLength{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}
//当前时间（毫秒）
+(NSString *)getNowTimeTimes{
    
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
- (NSString *)SHA256
{
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}
@end
