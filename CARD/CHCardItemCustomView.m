//
//  CHCardItemCustomView.m
//  CHCardView
//
//  Created by yaoxin on 16/10/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "CHCardItemCustomView.h"
#import "CHCardItemModel.h"

@interface CHCardItemCustomView ()
@property (nonatomic, weak) UIImageView *imgView;
@end

@implementation CHCardItemCustomView

- (void)setItemModel:(CHCardItemModel *)itemModel {
    _itemModel = itemModel;
    self.imgView.image = [UIImage imageNamed:itemModel.localImagename];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _imgView = img;
        img.clipsToBounds = YES;
    }
    return _imgView;
}

@end
