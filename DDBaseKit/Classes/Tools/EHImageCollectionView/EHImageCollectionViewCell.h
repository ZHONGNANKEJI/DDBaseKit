//
//  EHImageCollectionViewCell.h
//  EHome
//
//  Created by Lifee on 2018/9/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EHImageCollectionViewCell : BaseCollectionViewCell
@property (nonatomic ,strong) UIImage * image ;
@property (nonatomic ,assign) BOOL hideDelete ;

@property (nonatomic ,copy) void (^deleteCallback)(void) ;

@end

NS_ASSUME_NONNULL_END
