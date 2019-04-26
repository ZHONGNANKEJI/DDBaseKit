//
//  UIImageView+Additions.m
//  EHome
//
//  Created by Lifee on 2018/10/18.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "UIImageView+Additions.h"
#import "ApplicationManager.h"
@implementation UIImageView (Additions)


- (void)download_allowance_sd_setImageWithURL:(NSURL *)url {
    [self download_allowance_sd_setImageWithURL:url placeholderImage:nil];
}
- (void)download_allowance_sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    
    if (AppManager.netStatus == NetworkReachabilityStatusReachableViaWWAN && AppManager.dontAllowDownloadWhenNoneWifi == YES) {
        NSString * key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
        UIImage * image = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
        if (image) {
            [self setImage:image];
        }
        return ;
    }
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}
@end
