//
//  BaseWebViewController.h
//  EHome
//
//  Created by Lifee on 2018/10/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : BaseViewController
@property (nonatomic ,copy) NSString * url ;
@property (nonatomic , copy) void (^contentHeightBlock) (CGFloat webHeight);
@end

NS_ASSUME_NONNULL_END
