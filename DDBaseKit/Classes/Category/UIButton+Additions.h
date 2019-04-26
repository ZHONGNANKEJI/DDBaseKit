//
//  UIButton+Additions.h
//  EHome
//
//  Created by Lifee on 2018/10/18.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIButton+WebCache.h>

/**
 为了实现非wifi环境下是否允许自动下载图片功能
 UIbutton 在初始化的时候就需要给一张占位图
 */
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Additions)
- (void)download_allowance_sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state ;
- (void)download_allowance_sd_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder ;
//background
- (void)download_allowance_sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state;
- (void)download_allowance_sd_setBackgroundImageWithURL:(nullable NSURL *)url
                            forState:(UIControlState)state
                    placeholderImage:(nullable UIImage *)placeholder ;

@end

NS_ASSUME_NONNULL_END
