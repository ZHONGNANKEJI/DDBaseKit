//
//  SystemBaseTableViewController.m
//  EHome
//
//  Created by Lifee on 2018/9/20.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "SystemBaseTableViewController.h"
#import "ApplicationManager.h"
#import "AccessCallManager.h"
#import "UIView+ZNFrame.h"
#import <RTRootNavigationController/RTRootNavigationController.h>
@interface SystemBaseTableViewController ()
@property (nonatomic ,strong)UIButton * goBackBtn ;
@end

@implementation SystemBaseTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        //tabBar
        self.tabBarController.tabBar.hidden = NO ;
    }
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
        //tabBar
        self.tabBarController.tabBar.hidden = YES ;
    }
}
- (void)base_initView{};
- (void)base_backforward {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)base_relogin {
    
    [AppManager clearUserInfo];
    [[AccessCallManager manager] clearInfo];
    if ([AppManager.keyVC isKindOfClass:[self class]]) {
        UIViewController * loginVC = [NSClassFromString(@"LoginViewController") new];
        RTRootNavigationController * loginNav = [[RTRootNavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
    
}
-(UIButton *)goBackBtn{
    if (!_goBackBtn) {
        _goBackBtn = [UIButton new];
        [_goBackBtn addTarget:self action:@selector(base_backforward) forControlEvents:UIControlEventTouchUpInside];
        UIImage * image = [UIImage imageNamed:@"backIcon"];
        _goBackBtn.size = CGSizeMake(43, 40);
        [_goBackBtn setImage:image forState:UIControlStateNormal];
        _goBackBtn.size = CGSizeMake(23, 23);
        [_goBackBtn sizeToFit];
    }
    return _goBackBtn ;
}
@end
