//
//  BaseViewController.m
//  EHome
//
//  Created by Lifee on 2018/7/14.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseViewController.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "ApplicationManager.h"
#import "AccessCallManager.h"
#import "UIView+ZNFrame.h"
@interface BaseViewController ()
@property (nonatomic ,strong)UIButton * goBackBtn ;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        //tabBar
        self.tabBarController.tabBar.hidden = NO ;
    }
}
- (BOOL)backforwardHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //开启侧滑返回手势
    self.rt_disableInteractivePop = NO ;
    //初始化默认导航栏
    [self initSystemNavigationBar];
    //修改的导航栏
    [self base_initView];
    //global notifications
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(base_relogin)
                                                name:@"AccessTokenExpired"
                                              object:nil];
    
}
- (void)initSystemNavigationBar {
    self.navigationController.navigationBar.translucent = NO ;
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:self.goBackBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        self.tabBarController.tabBar.hidden = YES ;
    }
}
- (void)base_initView{
    
}
- (void)base_backforward {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)base_relogin {
    
    [AppManager clearUserInfo];
    [[AccessCallManager manager] clearInfo];
    if ([AppManager.keyVC isKindOfClass:[self class]] && ![AppManager.keyVC isKindOfClass:NSClassFromString(@"LoginViewController")]) {
        RTRootNavigationController * loginNav = [[RTRootNavigationController alloc]initWithRootViewController:[NSClassFromString(@"LoginViewController") new]];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
}
-(UIButton *)goBackBtn{
    if (!_goBackBtn) {
        _goBackBtn = [UIButton new];
        [_goBackBtn addTarget:self action:@selector(base_backforward) forControlEvents:UIControlEventTouchUpInside];
        UIImage * image = [UIImage imageNamed:@"backIcon"];
        if (self.customed_back_image) {
            image = self.customed_back_image ;
        }
        [_goBackBtn setBackgroundImage:image forState:UIControlStateNormal];
        _goBackBtn.size = CGSizeMake(23, 23);
        [_goBackBtn sizeToFit];
        _goBackBtn.hidden = [self backforwardHidden];
    }
    return _goBackBtn ;
}
@end
