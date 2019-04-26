//
//  BaseTableViewController.h
//  EHome
//
//  Created by Lifee on 2018/7/16.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef NS_ENUM(NSUInteger, NODATA_TYPE) {
    NODATA_TYPE_EMPTY,
    NODATA_TYPE_NOMORE
};
typedef NS_ENUM(NSInteger , UITableViewMJRefreshType) {
    UITableViewMJRefreshType_Refresh ,
    UITableViewMJRefreshType_More
};
@interface BaseTableViewController : BaseViewController<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic ,strong,readonly) UITableView * tableView ;
@property (nonatomic ,assign) NSInteger pageNumber ;
@property (nonatomic ,assign ,readonly) UITableViewMJRefreshType  mjType ;
@property (nonatomic , assign) NODATA_TYPE type;
- (instancetype)initWithStyle:(UITableViewStyle)style ;
- (void)setUpMJRefresh ;
- (void)base_data_request ;
- (void)stopMJAnimation ;
- (void)NoDataTips:(NODATA_TYPE)type;
@end
