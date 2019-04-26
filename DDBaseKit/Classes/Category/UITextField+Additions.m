//
//  UITextField+Additions.m
//  EHome
//
//  Created by Lifee on 2018/9/20.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "UITextField+Additions.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "EHToast.h"
#import "NSString+Additions.h"
static const void * placeholderTextColorKey = "placeholderTextColorKey";
static const void * placeholderTextFontKey = "placeholderTextFontKey";
static const void * limitInputKey = @"limitInputKey";
static const void * limitLengthKey = @"limitLengthKey";
@implementation UITextField (Additions)

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor{
    objc_setAssociatedObject(self, placeholderTextColorKey, placeholderTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setValue:placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (UIColor *)placeholderTextColor {
    return objc_getAssociatedObject(self, placeholderTextColorKey);
}
- (void)setPlaceholderTextFont:(UIFont *)placeholderTextFont {
    [self setValue:placeholderTextFont forKeyPath:@"_placeholderLabel.font"];
    return objc_setAssociatedObject(self, placeholderTextFontKey, placeholderTextFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)placeholderTextFont {
    return objc_getAssociatedObject(self, placeholderTextFontKey);
}
- (void)setLimitInput:(NSString *)limitInput{
    objc_setAssociatedObject(self, limitInputKey, limitInput, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[RACSignal combineLatest:@[self.rac_textSignal] reduce:^id _Nonnull{
        if (self.text.length > 0) {
            return @([self containUnlegal]);
        }
        return @(NO);
    }] subscribeNext:^(id  _Nullable x) {
        BOOL result = [x boolValue];
        if (result) {
            [EHToast toast:[NSString stringWithFormat:@"非法字符"]];
        }
    }];
}
- (NSString*)limitInput{
    return objc_getAssociatedObject(self, limitInputKey);
}
- (void)setLimitLength:(NSInteger)limitLength{
    objc_setAssociatedObject(self, limitLengthKey, @(limitLength), OBJC_ASSOCIATION_ASSIGN);
    [[RACSignal combineLatest:@[self.rac_textSignal] reduce:^id _Nonnull{
        return @([self beyondLength]);
    }] subscribeNext:^(id  _Nullable x) {
        BOOL result = [x boolValue];
        if (result) {
            [EHToast toast:[NSString stringWithFormat:@"最多只能输入%ld字符",limitLength]];
        }
    }];
}
- (NSInteger)limitLength{
    return [objc_getAssociatedObject(self, limitLengthKey) integerValue];
}
#pragma mark --
#pragma mark -- 限制输入长度 --
- (BOOL)beyondLength{
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    if (!position){
        //---字符处理
        if ([self.text getCharLength] > self.limitLength){
            //中文和emoj表情存在问题，需要对此进行处理
            NSRange range;
            NSUInteger inputLength = 0;
            for(int i=0; i < self.text.length && inputLength <= self.limitLength; i += range.length) {
                range = [self.text rangeOfComposedCharacterSequenceAtIndex:i];
                inputLength += [[self.text substringWithRange:range] getCharLength];
                if (inputLength > self.limitLength) {
                    NSString* newText = [self.text substringWithRange:NSMakeRange(0, range.location)];
                    self.text = newText;
                }
            }
            return YES;
        }
    }
    return NO;
}
#pragma mark --
#pragma mark -- 非法字符 --
- (BOOL)containUnlegal{
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    if (!position){
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",self.limitInput];
        if([pred evaluateWithObject:self.text]){
            return NO;
        }else{
            [self deleteBackward];

            return YES;
        }
    }
    return NO;
}
@end
