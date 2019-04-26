//
//  LocationManager.h
//  EHome
//
//  Created by cydida on 2018/12/18.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
#define Location_Manager [LocationManager manager]

@interface LocationManager : BaseModel
/**
 定位的城市
 */
@property (nonatomic , copy) NSString* locationCity;

/**
 当前选择的城市
 */
@property (nonatomic , copy) NSString* currentCity;
+ (instancetype)manager;
- (void)startLocation;
@end

NS_ASSUME_NONNULL_END
