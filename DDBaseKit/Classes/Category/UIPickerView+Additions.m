//
//  UIPickerView+Additions.m
//  EHome
//
//  Created by Lifee on 2019/1/4.
//  Copyright © 2019年 zhongnan. All rights reserved.
//

#import "UIPickerView+Additions.h"

@implementation UIPickerView (Additions)

@dynamic noneSeperator;
- (void)setNoneSeperator:(BOOL)noneSeperator {
    if (!noneSeperator) return ;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}
@end
