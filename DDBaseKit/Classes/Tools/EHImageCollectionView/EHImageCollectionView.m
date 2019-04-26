//
//  EHImageCollectionView.m
//  EHome
//
//  Created by Lifee on 2018/9/25.
//  Copyright © 2018年 zhongnan. All rights reserved.
//

#import "EHImageCollectionView.h"
#import "EHImageCollectionViewCell.h"
#import "UIView+ZNFrame.h"
static CGFloat leading_trailing_margin = 20 ;
@interface EHImageCollectionView()<UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) UICollectionView * collectionView ;
@property (nonatomic ,strong) NSMutableArray * dataSource ;
@property (nonatomic ,assign) BOOL hasBeenMax ;
@end

@implementation EHImageCollectionView

- (void)globeInit{
    _col = 3 ;
    _max = 6 ;
    _addIcon = [UIImage imageNamed:@"addIcon"];
    _dataSource = [NSMutableArray arrayWithObject:_addIcon];
    _hasBeenMax = NO;
    _canEdited = YES;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(self);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self globeInit];
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self globeInit];
    }
    return self ;
}
- (instancetype)init {
    if (self = [super init]) {
        [self globeInit];
    }
    return self ;
}

- (void)reload {
    [self.collectionView reloadData] ;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20 ;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10 ;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, leading_trailing_margin, 20, leading_trailing_margin) ;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"size === %@", NSStringFromCGSize(CGSizeMake((self.width - 4 * 20)/3,(self.width - 4 * 20)/3)));
    return CGSizeMake((self.width - (_col + 1) * leading_trailing_margin)/_col,(self.width - (_col + 1) * leading_trailing_margin)/_col) ;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    EHImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.dataSource[indexPath.item];

    if (_hasBeenMax) {
        cell.hideDelete = NO;
    }else{
        cell.hideDelete = (indexPath.item == _dataSource.count - 1) ? YES : NO;
    }
    if (!_canEdited) {
        cell.hideDelete = YES;
    }
//    __weak typeof(self) wSelf = self ;
    [cell setDeleteCallback:^{
        self.hasBeenMax = NO;
        [self.dataSource removeObjectAtIndex:indexPath.item];
        if (self.dataSource.count < self.max && self.canEdited && ![self.dataSource containsObject:self.addIcon]) {
            [self.dataSource addObject:self.addIcon];
        }
        
        if (self.deleteClick) {
            self.deleteClick(indexPath.item);
        }
        [self.collectionView reloadData];
    }];
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _dataSource.count - 1 && _canEdited) {
        if (self.newImageClick) {
            self.newImageClick();
        }
    }
}
- (void)setCanEdited:(BOOL)canEdited{
    _canEdited = canEdited;
    _dataSource = [[NSMutableArray alloc] init];
    [self.collectionView reloadData];
}
- (void)setImages:(NSArray<UIImage *> *)images {
    _images = images ;
    _dataSource = [NSMutableArray array];
    if (images.count >= _max) {
        _hasBeenMax = YES ;
        for (NSInteger i = 0 ; i <_max; i ++) {
            [_dataSource addObject:images[i]];
        }
    }else{
        _hasBeenMax = NO ;
        [_dataSource addObjectsFromArray:images];
        if (_canEdited) {
            [_dataSource addObject:_addIcon];
        }
    }
    [self.collectionView reloadData];
    //core and required.
    [self invalidateIntrinsicContentSize];
}
- (void)setImageStrings:(NSArray<NSString *> *)imageStrings {
    NSMutableArray* images = [[NSMutableArray alloc] init];
    for (NSString* s in imageStrings) {
        [images addObject:[UIImage imageNamed:s]];
    }
    [self setImages:images];
//    _imageStrings = imageStrings ;
//    _dataSource = [NSMutableArray array];
//    if (imageStrings.count >= _max) {
//        _hasBeenMax = YES ;
//        for (NSInteger i = 0 ; i <_max; i ++) {
//           [_dataSource addObject:[UIImage imageNamed:imageStrings[i]]];
//        }
//    }else{
//        _hasBeenMax = NO ;
//        for (NSString * s in imageStrings) {
//            [_dataSource addObject:[UIImage imageNamed:s]];
//        }
//        if (_canEdited) {
//            [_dataSource addObject:_addIcon];
//        }
//    }
//    [self.collectionView reloadData];
//    //core and required.
//    [self invalidateIntrinsicContentSize];
}
- (void)setCol:(NSInteger)col {
    _col = col ;
    [self.collectionView reloadData];
    //core and required.
    [self invalidateIntrinsicContentSize];
}
- (void)setMax:(NSInteger)max {
    _max = max ;
//    if (_imageStrings.count > 0) {
//        [self setImageStrings:_imageStrings];
//    }else if (_images.count > 0){
//        [self setImages:_images];
//    }
    if (_images.count > 0) {
        [self setImages:_images];
    }
    
}
- (void)setAddIcon:(UIImage *)addIcon {
    _addIcon = addIcon ;
    if (_dataSource.count <= 0) {
        return;
    }
    [_dataSource replaceObjectAtIndex:self.dataSource.count - 1 withObject:_addIcon];
    [self.collectionView reloadData];
}
- (CGSize)intrinsicContentSize {
//    NSLog(@"size == %@ ,scr == %f", NSStringFromCGSize(CGSizeMake(self.width, self.collectionView.height)) ,SCREEN_WIDTH);
    CGFloat h = 0.f  ;
    if (_dataSource.count % _col == 0) {
        NSInteger r = _dataSource.count / _col ;
        CGFloat w = (self.width - (_col + 1) * leading_trailing_margin) / _col ;
        h = r * w + (r - 1) * 20 + 2 * 20;
    }else{
        NSInteger r = _dataSource.count / _col + 1 ;
        CGFloat w = (self.width - (_col + 1) * leading_trailing_margin) / _col ;
        h = r * w + (r - 1) * 20 + 2 * 20;
    }
    return CGSizeMake(self.width, h);
}
// 适配xib。
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self.collectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.scrollEnabled = NO ;
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[EHImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView ;
}
@end
