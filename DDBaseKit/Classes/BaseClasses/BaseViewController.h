//
//  BaseViewController.h
//  EHome
//
//  Created by Lifee on 2018/7/14.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIImageView+Additions.h"
#import "UIButton+Additions.h"
@interface BaseViewController : UIViewController

@property (nonatomic ,strong) UIImage * customed_back_image ;
/**
 用于重写父类方法
 */
- (void)base_backforward ;
- (void)base_initView ;
- (BOOL)backforwardHidden;
@end
