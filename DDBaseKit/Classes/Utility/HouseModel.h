//
//  HouseModel.h
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"
#import "HouseUser.h"

/**
 房屋归属类型

 - HouseIdentityType_Owner: 户主
 - HouseIdentityType_Member: 成员
 - HouseIdentityType_Tenant: 租客
 */
typedef NS_ENUM(NSUInteger, HouseIdentityType) {
    HouseIdentityType_Owner = 0,
    HouseIdentityType_Member,
    HouseIdentityType_Tenant,
};

/**
 房屋审核状态

 - HouseVerityType_OK: 成功
 - HouseVerityType_Waiting: 审核中
 - HouseVerityType_Rejected: 拒绝
 */
typedef NS_ENUM(NSUInteger, HouseVerityType) {
    HouseVerityType_OK = 1,
    HouseVerityType_Waiting,
    HouseVerityType_Rejected,
};

@interface HouseModel : BaseModel<NSCoding>
//@property (nonatomic ,copy) NSString * house_no ;
//@property (nonatomic ,copy) NSString * household ;
//@property (nonatomic ,assign) NSInteger state ;
//@property (nonatomic ,assign) NSInteger type ;
//
//@property (nonatomic , copy) NSString* roomId;
@property (nonatomic , copy) NSString* houseStruct;

/**
 身份
 */
@property (nonatomic , assign) HouseIdentityType identity;

/**
 审核状态
 */
@property (nonatomic , assign) HouseVerityType shStatus;
@property (nonatomic , copy) NSString* cityName;
@property (nonatomic , copy) NSString* communityName;
@property (nonatomic , copy) NSString* countryName;
@property (nonatomic , copy) NSString* communityNo;
@property (nonatomic , assign) BOOL oftenStatus;

/**
 X栋X单元X室
 */
@property (nonatomic , copy) NSString* houseName;

/**
 昵称
 */
@property (nonatomic , copy) NSString* nickName;
@property (nonatomic , copy) NSString * phone ;
@property (nonatomic , copy) NSString * userId ;
@property (nonatomic , copy) NSString * headImgPath ;
@property (nonatomic , copy) NSString * ID ;
/**
 1:男
 */
@property (nonatomic , assign) NSInteger  sex;

/**
 真实姓名
 */
@property (nonatomic , copy) NSString * name;
@end
