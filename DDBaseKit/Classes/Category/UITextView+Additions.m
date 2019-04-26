//
//  UITextView+Additions.m
//  EHome
//
//  Created by Lifee on 2018/9/21.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "UITextView+Additions.h"
#import <objc/message.h>

static const void * placeholderKey = @"placeholderKey";
static const void * placeholderColorKey = @"placeholderColorKey";
static const void * placeholderLabelKey = @"placeholderLabelKey";

@interface UITextView()
@property (nonatomic ,strong) UILabel * placeholderLabel ;
@end

@implementation UITextView (Additions)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setFont:")),
                                       class_getInstanceMethod(self.class, @selector(swizzled_setFont:)));
    });
}
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, placeholderKey, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.placeholderLabel.text = placeholder ;
}
- (NSString *)placeholder {
    return objc_getAssociatedObject(self, placeholderKey);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, placeholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeholderLabel.textColor = placeholderColor ;
}
- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, placeholderColorKey);
}
- (void)swizzled_setFont:(UIFont *)font {
    [self swizzled_setFont:font];
    self.placeholderLabel.font = font;
}
- (UILabel *)placeholderLabel {
    UILabel * lb = objc_getAssociatedObject(self, placeholderLabelKey);
    if (!lb) {
        lb = [UILabel new];
        lb.numberOfLines = 0;
        lb.font = self.font ;
        [self addSubview:lb];
        [self setValue:lb forKey:@"_placeholderLabel"];
        objc_setAssociatedObject(self, placeholderLabelKey, lb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lb ;
}
@end
