//
//  UserInfo.h
//  EHome
//
//  Created by Lifee on 2018/8/28.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseModel.h"
#import "CommunityModel.h"
@interface UserInfo : BaseModel<NSCoding>

@property (nonatomic ,copy) NSString * login_name ;
@property (nonatomic ,copy) NSString * birthday ;
@property (nonatomic ,copy) NSString * head_img_path ;
@property (nonatomic ,copy) NSString * last_login_time ;
@property (nonatomic ,copy) NSString * PersonnelID ;
@property (nonatomic , copy) NSString * video_token;
/**
 是否设置了支付密码
 */
@property (nonatomic ,assign) BOOL  is_pay_password ;
@property (nonatomic ,copy) NSString * user_id ;
@property (nonatomic ,copy) NSString * f_pinyin ;
@property (nonatomic ,copy) NSString * city_code ;
@property (nonatomic ,copy) NSString * sex ;
@property (nonatomic ,copy) NSString * city_name ;
@property (nonatomic ,copy) NSString * signature ;
@property (nonatomic ,copy) NSString * assets ;
@property (nonatomic ,copy) NSString * name ;
@property (nonatomic ,assign) NSInteger  type ;
@property (nonatomic ,assign) NSInteger  state ;
@property (nonatomic ,copy) NSString * id_number ;
@property (nonatomic ,copy) NSString * level ;
@property (nonatomic ,copy) NSString * phone ;
@property (nonatomic ,strong) NSArray * householdList ;
@property (nonatomic ,copy) NSString * nick_name ;
@property (nonatomic ,copy) NSString * access_token ;
@property (nonatomic ,copy) NSString * integral ;

/**
 用户小区信息
 */
@property (nonatomic ,strong) NSArray <CommunityModel *> *communities ;

/**
 房屋列表
 */
@property (nonatomic ,strong) NSArray <HouseModel *> * houses;

/**
 成员列表
 */
@property (nonatomic ,strong) NSArray <HouseModel *> * families;
/**
 户主在成员列表中的index
 */
@property (nonatomic , assign) NSInteger hostIndex;
/**
 用户选择的小区
 */
@property (nonatomic , strong) HouseModel * selectedHouse;
/**
 用户选择的小区的审核状态
 */
@property (nonatomic ,assign) HouseVerityType selectedHouseStatus ;
/**
 用户类型 该值取自community 。
 */
@property (nonatomic , assign , readonly) HouseIdentityType usrType;

- (void)infoWithDicionary:(NSDictionary *)dic ;
//- (void)updateValue:(id)val forKey:(NSString *)key ;

@end
