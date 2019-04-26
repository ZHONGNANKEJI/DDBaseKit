//
//  BaseTableViewController.m
//  EHome
//
//  Created by Lifee on 2018/7/16.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "DDBaseKit.h"
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@interface BaseTableViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic ,strong) UITableView * baseTableView;
@property (nonatomic ,assign) UITableViewStyle  tableViewStyle ;


@end

@implementation BaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super init]) {
        _tableViewStyle = style ;
        _pageNumber = 1 ;
    }
    return self ;
}
- (instancetype)init{
    if (self = [super init]) {
        _tableViewStyle = UITableViewStylePlain ;
        _pageNumber = 1 ;
    }
    return self ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_data_request];
}
- (void)setUpMJRefresh {
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
//    self.baseTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.baseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.baseTableView.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX ? 34 : 0;
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
//    [RACObserve(self.baseTableView.mj_footer, frame)subscribeNext:^(id x) {
//        //这里的意思是监视mj_footer的frame变化，可以使用kvo代替RACObserve
//        CGPoint point = [self.baseTableView convertPoint:self.baseTableView.mj_footer.frame.origin toView:window];
//        if (point.y < window.frame.size.height) {
//            [(MJRefreshAutoNormalFooter *)self.baseTableView.mj_footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//            [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
//            }
//    }];

}
- (void)requestNewData {
    self.pageNumber = 1 ;
    _mjType = UITableViewMJRefreshType_Refresh ;
    [self.baseTableView.mj_footer resetNoMoreData];
    [self base_data_request];
}
- (void)requestMoreData {
    self.pageNumber ++ ;
    _mjType = UITableViewMJRefreshType_More ;
    [self base_data_request];
}
- (void)base_data_request{
    
}
- (void)base_initView{
    [self.view addSubview:self.baseTableView];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.top.leading.bottom.trailing.mas_equalTo(self.view);
        }
    }];
    self.baseTableView.emptyDataSetSource = self;
    self.baseTableView.emptyDataSetDelegate = self;
}

- (void)stopMJAnimation {
    if (_mjType == UITableViewMJRefreshType_Refresh) {
        [self.baseTableView.mj_header endRefreshing];
    }else{
        [self.baseTableView.mj_footer endRefreshing];
    }
}
- (void)setNoData{
    
    [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
}
- (void)NoDataTips:(NODATA_TYPE)type{
    [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
    if (type == NODATA_TYPE_EMPTY) {
        self.baseTableView.mj_footer.hidden = YES;
        [(MJRefreshAutoNormalFooter *)self.baseTableView.mj_footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    }else if (type == NODATA_TYPE_NOMORE){
        [(MJRefreshAutoNormalFooter *)self.baseTableView.mj_footer setTitle:@"到底啦~" forState:MJRefreshStateNoMoreData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark --
#pragma mark -- DZNEmptyDataSetSource,DZNEmptyDataSetDelegate --

//空白页面显示
- (UIImage*)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"empty"];
}
- (NSAttributedString*)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"暂无数据" attributes:@{NSFontAttributeName:font_16,NSForegroundColorAttributeName:GET_COLOR_BY_LONG(0x666666)}];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50;
}
- (UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:_tableViewStyle];
        _baseTableView.delegate = self ;
        _baseTableView.dataSource = self ;
        _baseTableView.tableFooterView = [UIView new];
        _baseTableView.estimatedRowHeight = 0;
        _baseTableView.estimatedSectionHeaderHeight = 0;
        _baseTableView.estimatedSectionFooterHeight = 0;
        _baseTableView.showsVerticalScrollIndicator = NO;
        [_baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _baseTableView ;
}

- (UITableView *)tableView{
    return self.baseTableView ;
}

@end
