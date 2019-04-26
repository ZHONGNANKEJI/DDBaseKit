//
//  BaseCollectionViewController.m
//  EHome
//
//  Created by Lifee on 2018/7/16.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface BaseCollectionViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic ,strong) UICollectionView * baseCollectionView ;

@end

@implementation BaseCollectionViewController
- (instancetype)init{
    if (self = [super init]) {
        _pageNumber = 1 ;
    }
    return self ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_data_request];
}
- (void)base_initView{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.top.leading.bottom.trailing.mas_equalTo(self.view);
        }
    }];
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
}
- (void)setUpMJRefresh {
    self.baseCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
    self.baseCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}
- (void)requestNewData {
    self.pageNumber = 1 ;
    _mjType = UICollectionViewMJRefreshType_Refresh ;
    [self stopMJAnimation];
}
- (void)requestMoreData {
    self.pageNumber ++ ;
    _mjType = UICollectionViewMJRefreshType_More ;
    [self stopMJAnimation];
}
- (void)base_data_request{
    
}
- (void)stopMJAnimation {
    if (self.mjType == UICollectionViewMJRefreshType_Refresh) {
        [self.baseCollectionView.mj_header endRefreshing];
    }else{
        [self.baseCollectionView.mj_footer endRefreshing];
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN ;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [UICollectionViewCell new] ;
}
- (UICollectionView *)baseCollectionView{
    if (!_baseCollectionView) {
         _flowLayout = [UICollectionViewFlowLayout new];
        _baseCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _baseCollectionView.showsVerticalScrollIndicator = NO ;
        _baseCollectionView.backgroundColor = [UIColor whiteColor];
        _baseCollectionView.delegate = self ;
        _baseCollectionView.dataSource = self ;
        _baseCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _baseCollectionView ;
}
- (UICollectionView *)collectionView{
    return self.baseCollectionView;
}
@end
