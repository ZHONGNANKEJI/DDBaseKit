//
//  UITextField+Additions.h
//  EHome
//
//  Created by Lifee on 2018/9/20.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Additions)
@property (nonatomic ,strong) IBInspectable UIColor * placeholderTextColor;
@property (nonatomic ,strong) IBInspectable UIFont  * placeholderTextFont ;
@property (nonatomic ,copy) IBInspectable NSString* limitInput;
@property (nonatomic ,assign) IBInspectable NSInteger limitLength;
@end

NS_ASSUME_NONNULL_END
