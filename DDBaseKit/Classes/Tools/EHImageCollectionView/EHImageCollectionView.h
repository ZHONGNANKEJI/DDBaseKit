//
//  EHImageCollectionView.h
//  EHome
//
//  Created by Lifee on 2018/9/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseView.h"

/**
 本视图重写了intrinsicContentSize ，故类似UILabel 不设置size 也可以显示。
 1.initWithFrame 中frame 高度将不起作用，高度是重写计算的。
 2.在使用xib 时，通常给本视图添加上、左、右 三条约束，另外为了不报错，应该把intrinsicContentSize 设置为Placeholder！。
 */
NS_ASSUME_NONNULL_BEGIN
@interface EHImageCollectionView : BaseView

@property (nonatomic , assign) BOOL canEdited;
/**
 最多展示多少张图片 ，达到max ，不显示添加按钮。
 */
@property (nonatomic ,assign)IBInspectable NSInteger max ;
/**
 一行最多几张图片
 */
@property (nonatomic ,assign)IBInspectable NSInteger col ;
/**
 添加图片的图标
 */
@property (nonatomic ,strong) UIImage * addIcon ;

/**
 图片数组
 */
@property (nonatomic ,strong) NSArray <UIImage *>* images ;

/**
 图片名数组
 */
@property (nonatomic ,strong) NSArray <NSString *>* imageStrings ;

/**
 添加图片点击事件
 */
@property (nonatomic ,copy) void (^newImageClick)(void) ;

/**
 删除某图片，index = 0 ～ count-1 。
 */
@property (nonatomic ,copy) void (^deleteClick)(NSInteger index) ;

//- (void)reload ;
@end

NS_ASSUME_NONNULL_END
