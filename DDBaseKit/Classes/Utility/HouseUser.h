//
//  HouseUser.h
//  EHome
//
//  Created by Lifee on 2018/10/17.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HouseUser : BaseModel
@property (nonatomic ,copy) NSString * address ;
@property (nonatomic ,copy) NSString * birthday ;
@property (nonatomic ,copy) NSString * city_code ;
@property (nonatomic ,copy) NSString * city_name ;
@property (nonatomic ,copy) NSString * door_no ;
@property (nonatomic ,copy) NSString * head_img_path ;
@property (nonatomic ,copy) NSString * id_number ;
@property (nonatomic ,copy) NSString * name ;
@property (nonatomic ,copy) NSString * order ;
@property (nonatomic ,assign) NSInteger state ;
@property (nonatomic ,copy) NSString * type ;
@property (nonatomic ,copy) NSString * uqid ;
@property (nonatomic ,copy) NSString * phone ;
@property (nonatomic ,copy) NSString * ID ;

@end

NS_ASSUME_NONNULL_END
