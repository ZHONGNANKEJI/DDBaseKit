//
//  BaseItem.h
//  EHome
//
//  Created by Lifee on 2018/9/27.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseItem : BaseModel
@property (nonatomic ,copy) NSString * sel_image ;
@property (nonatomic ,copy) NSString * normal_image ;
@property (nonatomic ,copy) NSString * title ;
@property (nonatomic ,copy) NSString * vc ;
@end

NS_ASSUME_NONNULL_END
