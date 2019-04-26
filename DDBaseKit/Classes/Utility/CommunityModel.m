//
//  CommunityModel.m
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"houseList":[HouseModel class],
             };
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"communityId":@"id",
             @"houseStruct":@"struct"
             };
}
- (NSString *)name {
    if (!_name) {
        _name = @"选择小区";
    }
    return _name ;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self yy_modelInitWithCoder:aDecoder];
}
@end
