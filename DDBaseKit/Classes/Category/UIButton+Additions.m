//
//  UIButton+Additions.m
//  EHome
//
//  Created by Lifee on 2018/10/18.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "UIButton+Additions.h"
#import "ApplicationManager.h"
@implementation UIButton (Additions)
- (void)download_allowance_sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state {
    [self download_allowance_sd_setImageWithURL:url forState:state placeholderImage:nil];
}
- (void)download_allowance_sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    
    if (AppManager.netStatus == NetworkReachabilityStatusReachableViaWWAN && AppManager.dontAllowDownloadWhenNoneWifi == YES) {
        
       NSString * key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
        UIImage * image = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
        if (image) {
            [self setImage:image forState:state];
        }
        return ;
    }
    [self sd_setImageWithURL:url forState:state placeholderImage:placeholder];
}

- (void)download_allowance_sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state {
    [self download_allowance_sd_setBackgroundImageWithURL:url forState:state placeholderImage:nil];
}
- (void)download_allowance_sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder{
    
    if (AppManager.netStatus == NetworkReachabilityStatusReachableViaWWAN && AppManager.dontAllowDownloadWhenNoneWifi == YES) {
        
        NSString * key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
        UIImage * image = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
        if (image) {
            [self setBackgroundImage:image forState:state];
        }
        return ;
    }
    [self sd_setBackgroundImageWithURL:url forState:state];
}

@end
