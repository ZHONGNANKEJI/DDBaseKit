//
//  AccessCallManager.m
//  EHome
//
//  Created by cydida on 2018/12/24.
//  Copyright © 2018 zhongnan. All rights reserved.
//

#import "AccessCallManager.h"
//#import "VideoCallVC.h"
#import <AVFoundation/AVFoundation.h>
#if !TARGET_IPHONE_SIMULATOR
@interface AccessCallManager ()<UCSTCPDelegateBase,UCSEventDelegate>
@property (nonatomic , strong) UCSTcpClient* tcpClient;
@property (nonatomic , strong) UCSService* ucsService;
@property (nonatomic , copy) NSString* callId;
@property (nonatomic , copy) NSString* callNumber;
@property (nonatomic , copy) void(^hangupBlock)(NSString * reason);
@property (nonatomic , copy) void(^openBlock)(void);
@end
@implementation AccessCallManager
static AccessCallManager* _manager = nil;
- (void)dealloc{
    NSLog(@"*******dealloc*******");
}
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self manager];
}
- (instancetype)init {
    if (self = [super init]) {
//        self.tcpClient = [UCSTcpClient sharedTcpClientManager];
//        [self.tcpClient setTcpDelegate:self];
        self.ucsService = [[UCSService alloc] initWithDelegate:self];
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            
        }];
    }
    return self ;
}
- (UCSTcpClient *)tcpClient {
    if (!_tcpClient) {
        _tcpClient = [UCSTcpClient sharedTcpClientManager];
        [_tcpClient setTcpDelegate:self];
    }
    return _tcpClient ;
}
#pragma mark --
#pragma mark -- 视频时开门 --
- (void)sendTransDataForOpenDoor{
    NSDictionary* dic = @{@"command":@"ack_open",
                          @"timestamp":[NSString getNowTimeTimes],
                          @"sign":[[[NSString stringWithFormat:@"%@&ack_open",[NSString getNowTimeTimes]] SHA256] uppercaseString]
                          };
    NSString* cmdStr = [dic yy_modelToJSONString];
//    NSData* json = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString* cmdStr = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    UCSTCPTransParentRequest* tcpReq = [UCSTCPTransParentRequest initWithCmdString:cmdStr receiveId:self.callNumber];
    [self.tcpClient sendTransParentData:tcpReq success:^(UCSTCPTransParentRequest *request) {
    } failure:^(UCSTCPTransParentRequest *request, UCSError *error) {
        NSDictionary* infoDic = [NSDictionary yy_modelWithJSON:request.cmdString];
        [EHToast toast:infoDic[@"msg"]];
    }];
}

/**
 TCP连接状态
 */
- (void)didConnectionStatusChanged:(UCSConnectionStatus)connectionStatus error:(UCSError *)error{
    switch (connectionStatus) {
        case UCSConnectionStatus_loginSuccess:
            
            break;
        case UCSConnectionStatus_ConnectFail:
            
            break;
        case UCSConnectionStatus_AbnormalDisconnection:
            
            break;
        case UCSConnectionStatus_StartReConnect:
            
            break;
        case UCSConnectionStatus_ReConnecting:
            
            break;
        case UCSConnectionStatus_ReConnectSuccess:
        {
            [self.tcpClient login_uninitWithFlag:0];
            [self.tcpClient login_connect:User_Info.video_token success:^(NSString *userId) {
                
            } failure:^(UCSError *error) {
                
            }];
        }
            break;
        case UCSConnectionStatus_ReConnectFail:
            
            break;
        case UCSConnectionStatus_BeClicked:
            
            break;
        case UCSConnectionStatus_SignOut:
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveTransParentData:(UCSTCPTransParent *)objcts {
    if (objcts != nil) {
        NSData* jsonData = [objcts.cmdString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* infoDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([infoDic[@"command"] isEqualToString:@"reply_open"]) {
            if ([infoDic[@"success"] boolValue]) {
                [EHToast toast:@"开门成功"];
            }else {
                [EHToast toast:infoDic[@"msg"]];
            }
        }
    }
}

- (void)onInitEngineSuccessful:(NSInteger)result{
    //0 表示成功  成功后连接云平台
    
    if (result == 0) {
        //登录前先断开连接
        [self.tcpClient login_uninitWithFlag:YES];
        [self.tcpClient login_connect:User_Info.video_token success:^(NSString *userId) {
            NSLog(@"************tcp登录成功*****************");
        } failure:^(UCSError *error) {
            
        }];
    }
}
//- (void)UCS_TCP_LoginSuccess:(void (^)(NSString * _Nonnull))success failure:(void (^)(UCSError * _Nonnull))failure{
//    if ([self.tcpClient login_isConnected]) {
//        //登录前先断开连接
//        [self.tcpClient login_uninitWithFlag:0];
//        [self.tcpClient login_connect:User_Info.video_token success:^(NSString *userId) {
//            success(userId);
//        } failure:^(UCSError *error) {
//            failure(error);
//        }];
//    }
//}
- (void)onIncomingCall:(NSString *)callid withcalltype:(UCSCallTypeEnum)callType withcallinfo:(NSDictionary *)callinfo{
    self.callId = callid;
    self.callNumber = callinfo[@"callerNumber"];
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    if (state == UIApplicationStateActive) {
//        VideoCallVC* vc = [[VideoCallVC alloc] init];
//        [AppManager.keyVC presentViewController:vc animated:YES completion:nil];
    }else if (state == UIApplicationStateBackground){
        // 1.创建通知
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        // 2.设置通知的必选参数
        // 设置通知显示的内容
        localNotification.alertBody = @"访客来电";
        // 设置通知的发送时间,单位秒
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
        //解锁滑动时的事件
        localNotification.alertAction = @"";
        //收到通知时App icon的角标
        localNotification.applicationIconBadgeNumber = 0;
        localNotification.userInfo = @{@"type":Local_Push_Call};
        //推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
        localNotification.soundName = @"hold.wav";
        
        // 立即发送通知
         [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
    
}
- (UIView*)allocViewWithFrame:(CGRect)frame{
    return [self.ucsService allocCameraViewWithFrame:frame];
}
- (void)answerWithLocal:(UIView *)localView remote:(UIView *)remoteView hangup:(nonnull void (^)(NSString * _Nonnull))block{
    [self.ucsService answer:self.callId];
    UCSVideoEncAttr *vEncAttr = [[UCSVideoEncAttr alloc] init] ;
    vEncAttr.uStartBitrate = 300;
    vEncAttr.uMaxBitrate =  900;
    vEncAttr.uMinBitrate = 150;
    [self.ucsService setVideoAttr:vEncAttr];
    BOOL result = [self.ucsService initCameraConfig:localView withRemoteVideoView:remoteView withRender:RENDER_ALLFULLSCREEN];
    self.hangupBlock = block;
    if (result) {
        [self.ucsService setSpeakerphone:YES];
    }
}
- (NSString*)callId{
    return _callId;
}
- (void)hangUp:(void (^)(NSString * _Nonnull))block{
    [self.ucsService reject:self.callId];
    self.callId = nil;
    self.hangupBlock = block;
}
//未接通
- (void)noAnwser:(void (^)(NSString * _Nonnull))block{
    self.callId = nil;
    self.hangupBlock = block;
}
- (void)onAnswer:(NSString *)callid{
    self.callId = callid;
}

- (void)onHangUp:(NSString *)callid withReason:(UCSReason *)reason{
    self.callId = nil;
    if (self.hangupBlock) {
        self.hangupBlock(reason.msg);
    }
}
- (void) onDialFailed:(NSString*)callid  withReason:(UCSReason*)reason{
    
}
- (BOOL)isHeadsetPluggedIn {
    AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription* desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones])
            return YES;
    }
    return NO;
}
- (void)clearInfo{
    [self.tcpClient login_uninitWithFlag:YES];
    _ucsService = nil;
    _tcpClient = nil;
    _callId = nil;
    _callNumber = nil;
}
@end

#else

@interface AccessCallManager ()

@end
@implementation AccessCallManager
static AccessCallManager* _manager = nil;
- (void)dealloc{
    NSLog(@"*******dealloc*******");
}
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}
- (void)clearInfo{
}
@end
#endif

