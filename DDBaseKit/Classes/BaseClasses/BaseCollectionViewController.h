//
//  BaseCollectionViewController.h
//  EHome
//
//  Created by Lifee on 2018/7/16.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+Additions.h"
#import "UIButton+Additions.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef NS_ENUM(NSInteger , UICollectionViewMJRefreshType) {
    UICollectionViewMJRefreshType_Refresh ,
    UICollectionViewMJRefreshType_More
};
@interface BaseCollectionViewController : BaseViewController<
UICollectionViewDelegate ,
UICollectionViewDataSource ,
UICollectionViewDelegateFlowLayout
>

/**
 在子类种重新设置collectionView 的约束需要 使用 mas_remakeConstraints
 */
@property (nonatomic ,strong ,readonly) UICollectionView * collectionView ;
@property (nonatomic ,strong ,readonly) UICollectionViewFlowLayout * flowLayout ;
@property (nonatomic ,assign) NSInteger pageNumber ;

@property (nonatomic ,assign ,readonly) UICollectionViewMJRefreshType  mjType ;

- (void)setUpMJRefresh ;
- (void)base_data_request ;
- (void)stopMJAnimation ;

@end
