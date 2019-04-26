//
//  EHToast.m
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "EHToast.h"
#import "DDBaseKit.h"
#define RequestMessage @"请求中..."

@implementation EHToast{
    
    UIButton * _contentView;
    CGFloat    _duration;

    UIWindow * _instanceWindow ;
    UIWindow * _realWindow ;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
}


- (id)initWithText:(NSString *)text_ duration:(CGFloat)duration{
    if (self = [super init]) {

        _duration = duration;

        _realWindow = [UIApplication sharedApplication].keyWindow ;
        _instanceWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

        UIFont *font = [UIFont boldSystemFontOfSize:17];
        CGRect textSize = [text_ boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.size.width + 12, textSize.size.height + 12)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text_;
        textLabel.numberOfLines = 0;

        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.borderWidth = 1.0f;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        _contentView.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                         action:@selector(toastTaped:)
               forControlEvents:UIControlEventTouchUpInside];
        _contentView.alpha = 1;
        _contentView.center = _instanceWindow.center;
        [_instanceWindow addSubview:_contentView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self dismiss];
}
-(void)toastTaped:(UIButton *)sender_{
    [self dismiss];
}

- (void)show{

    [_realWindow resignKeyWindow];
    [_instanceWindow makeKeyAndVisible];

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self->_contentView.alpha = 1;
                     }completion:^(BOOL finished) {
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self->_duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismiss];
                         });
                     }];
}
- (void)dismiss {

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self->_contentView.alpha = 0;
                     }completion:^(BOOL finished) {

                         [self->_contentView removeFromSuperview];

                         [self->_instanceWindow resignKeyWindow];
                         [self->_realWindow makeKeyAndVisible];

                     }];

}
//
//- (void)showFromTopOffset:(CGFloat) top_{
//
//    _contentView.centerY = top_ + _contentView.frame.size.height/2 ;
//    [self show];
//}
//
//- (void)showFromBottomOffset:(CGFloat) bottom_{
//
//    _contentView.centerY = SCREEN_HEIGHT - (bottom_ + _contentView.frame.size.height/2) ;
//    [self show];
//}


+ (void)toast:(NSString *)text_{
    [self toast:text_ duration:2];
}

+ (void)toast:(NSString *)text_
            duration:(CGFloat)duration_{
    EHToast *toast = [[EHToast alloc] initWithText:text_ duration:duration_];
    [toast show];
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setMinimumDismissTimeInterval:duration_];
//    [SVProgressHUD showInfoWithStatus:text_];
}
//
//+ (void)toast:(NSString *)text_
//           topOffset:(CGFloat)topOffset_{
//    [EHToast toast:text_  topOffset:topOffset_ duration:DEFAULT_DISPLAY_DURATION];
//}
//
//+ (void)toast:(NSString *)text_
//           topOffset:(CGFloat)topOffset_
//            duration:(CGFloat)duration_{
//    EHToast *toast = [[EHToast alloc] initWithText:text_ duration:duration_];
//    [toast showFromTopOffset:topOffset_];
//}
//
//+ (void)toast:(NSString *)text_
//        bottomOffset:(CGFloat)bottomOffset_{
//    [EHToast toast:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
//}
//
//+ (void)toast:(NSString *)text_
//        bottomOffset:(CGFloat)bottomOffset_
//            duration:(CGFloat)duration_{
//    EHToast *toast = [[EHToast alloc] initWithText:text_ duration:duration_];
//    [toast showFromBottomOffset:bottomOffset_];
//
//}

//


@end
