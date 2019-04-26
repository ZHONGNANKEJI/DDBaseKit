//
//  UIView+Xib.h
//  EHome
//
//  Created by Lifee on 2018/8/28.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ZNFrame.h"
@interface UIView (Xib)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
