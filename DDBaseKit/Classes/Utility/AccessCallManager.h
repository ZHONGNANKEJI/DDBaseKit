//
//  AccessCallManager.h
//  EHome
//
//  Created by cydida on 2018/12/24.
//  Copyright © 2018 zhongnan. All rights reserved.
//

#import "BaseModel.h"

#if !TARGET_IPHONE_SIMULATOR
#import "UCSTCPCommonClass.h"
#import "UCSService.h"
#import "UCSEvent.h"
#import "UCSTCPSDK.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AccessCallManager : BaseModel

+ (instancetype)manager;
//#if !TARGET_IPHONE_SIMULATOR
- (NSString*)callId;
- (UIView*)allocViewWithFrame:(CGRect)frame;
- (void)answerWithLocal:(UIView *)localView remote:(UIView *)remoteView hangup:(void(^)(NSString* reason))block;
- (void)hangUp:(void(^)(NSString* reason))block;
- (void)noAnwser:(void(^)(NSString* reason))block;
- (void)clearInfo;
- (void)sendTransDataForOpenDoor;
//#endif

@end


NS_ASSUME_NONNULL_END
