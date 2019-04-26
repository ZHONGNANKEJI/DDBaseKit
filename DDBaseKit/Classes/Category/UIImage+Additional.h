//
//  UIImage+Additional.h
//  EHome
//
//  Created by Lifee on 2018/10/10.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImage (Additional)
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius ;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;
- (UIImage *)imageByResizeToSize:(CGSize)size ;
@end


