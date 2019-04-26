//
//  RSAUtil.h
//  EHome
//
//  Created by cydida on 2019/2/18.
//  Copyright © 2019 zhongnan. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSAUtil : BaseModel
//*********************************    RSA加密     *******************************************

/**
 RSA公钥加密(返回Base64编码的字符串)
 
 @param str    待加密字符串
 @param pubKey 公钥
 
 @return 加密完成后的字符串(Base64编码之后)
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;


/**
 RSA公钥加密(返回二进制数据)
 
 @param data   待加密数据
 @param pubKey 公钥
 
 @return 加密完成后的数据
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
@end

NS_ASSUME_NONNULL_END
