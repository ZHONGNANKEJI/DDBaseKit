//
//  SystemBaseTableViewController.h
//  EHome
//
//  Created by Lifee on 2018/9/20.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIImageView+Additions.h"
#import "UIButton+Additions.h"
//该类基本适用于静态表
@interface SystemBaseTableViewController : UITableViewController
/**
 用于重写父类方法
 */
- (void)base_backforward ;
- (void)base_initView ;

@end


