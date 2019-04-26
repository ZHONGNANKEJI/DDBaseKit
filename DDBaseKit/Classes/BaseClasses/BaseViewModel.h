//
//  BaseViewModel.h
//  EHome
//
//  Created by Lifee on 2018/7/16.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface BaseViewModel : NSObject
@property (nonatomic , copy) NSString* curr_page;
@property (nonatomic , copy) NSString* total_page;

@end
