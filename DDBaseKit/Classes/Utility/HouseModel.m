//
//  HouseModel.m
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "HouseModel.h"

@implementation HouseModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self yy_modelInitWithCoder:aDecoder];
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"roomId":@"id"};
}@end
