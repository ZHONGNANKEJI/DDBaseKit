//
//  BaseTableViewHeaderFooterView.m
//  EHome
//
//  Created by Lifee on 2018/9/27.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "BaseTableViewHeaderFooterView.h"

@implementation BaseTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self ;
}

@end
