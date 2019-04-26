//
//  CommunityModel.h
//  EHome
//
//  Created by Lifee on 2018/8/29.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"
#import "HouseModel.h"

@interface CommunityModel : BaseModel<NSCoding>

@property (nonatomic ,strong) NSArray <HouseModel *> *houseList ;
/**
 小区名
 */
@property (nonatomic ,copy) NSString * name ;
@property (nonatomic ,assign) NSInteger quarters_id ;

@property (nonatomic , copy) NSString* cityName;
@property (nonatomic , copy) NSString* communityName;
@property (nonatomic , copy) NSString* communityNo;
@property (nonatomic , copy) NSString* countryName;
@property (nonatomic , copy) NSString* communityId;
//以下为小区单元
@property (nonatomic , copy) NSString* houseStruct;
@property (nonatomic , copy) NSString* unitName;
@property (nonatomic , copy) NSString* unitId;
//以下为
@end
