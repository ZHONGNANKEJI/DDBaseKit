//
//  UserInfo.m
//  EHome
//
//  Created by Lifee on 2018/8/28.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "UserInfo.h"
#import "ApplicationManager.h"
#import "NSString+Additions.h"
#import <objc/message.h>

@interface UserInfo()
@end

@implementation UserInfo

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"houses",
             @"families",
             @"hostIndex",
             @"selectedHouse",
             @"selectedHouseStatus",
             @"usrType"];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)infoWithDicionary:(NSDictionary *)dic {
    [self yy_modelSetWithDictionary:dic];
    [NSKeyedArchiver archiveRootObject:self toFile:usr_info_path()];
}
- (HouseModel*)selectedHouse{
    if (!_selectedHouse) {
        _selectedHouse = [[HouseModel alloc] init];
        _selectedHouse.communityName = @"请选择小区";
    }
    return _selectedHouse;
}
- (HouseVerityType)selectedHouseStatus{
    return self.selectedHouse.shStatus;
}
- (NSInteger)hostIndex{
    for (HouseModel* model in self.families) {
        if (model.identity == HouseIdentityType_Owner) {
            return [self.families indexOfObject:model];
        }
    }
    return -1;
}
- (HouseIdentityType)usrType{
    return self.selectedHouse.identity;
}
- (NSString *)access_token {
    if (!_access_token) {
        _access_token = @"";
    }
    return _access_token ;
}
- (NSString *)nick_name {
    if ([_nick_name is_not_empty] == NO) {
        return self.phone;
    }
    return _nick_name ;
}
//modify  info .
//- (void)updateValue:(id)val forKey:(NSString *)key {
//    //change
//    NSString * setterString = [NSString stringWithFormat:@"set%@%@:", [[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]];
//    SEL selector = NSSelectorFromString(setterString);
//    objc_msgSend(self,selector ,val);
//}
@end
