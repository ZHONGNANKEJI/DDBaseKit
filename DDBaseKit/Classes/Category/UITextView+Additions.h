//
//  UITextView+Additions.h
//  EHome
//
//  Created by Lifee on 2018/9/21.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>

//ios 9 以下使用会崩溃
@interface UITextView (Additions)

@property (nonatomic ,copy) IBInspectable NSString * placeholder NS_AVAILABLE_IOS(9_0);
@property (nonatomic ,strong) IBInspectable UIColor * placeholderColor NS_AVAILABLE_IOS(9_0);
//placeholder 必须与textView font 相同，否则会使placeholder 位置错乱。此属性不可用。
//@property (nonatomic ,strong) IBInspectable UIFont  * placeholderFont;
@end


