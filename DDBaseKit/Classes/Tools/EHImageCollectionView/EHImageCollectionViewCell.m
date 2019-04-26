//
//  EHImageCollectionViewCell.m
//  EHome
//
//  Created by Lifee on 2018/9/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "EHImageCollectionViewCell.h"
#import "DDBaseKit.h"
@interface EHImageCollectionViewCell()
@property (nonatomic ,strong) UIImageView * mainImageView ;
@property (nonatomic ,strong) UIButton * deleteBtn;
@end

@implementation EHImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.deleteBtn];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.trailing.mas_equalTo(self.contentView);
        }];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(44, 20));
        }];
    }
    return self ;
}
- (void)deleteClick {
    if (self.deleteCallback) {
        self.deleteCallback();
    }
}
- (void)setImage:(UIImage *)image {
    _image = image ;
    self.mainImageView.image = image;
}
- (void)setHideDelete:(BOOL)hideDelete {
    _hideDelete = hideDelete ;
    self.deleteBtn.hidden = hideDelete ;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:GET_COLOR_BY_LONG(0x3F86FF)];
        [_deleteBtn.titleLabel setFont:font_12];
        [_deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn ;
}
- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [UIImageView new];
    }
    return _mainImageView ;
}
@end
