//
//  CHCardView.m
//  CHCardView
//
//  Created by yaoxin on 16/10/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "CHCardView.h"
#import "CHCardItemCustomView.h"
#import "CHCardItemModel.h"

@interface CHCardView () <CHCardItemViewDelegate>
@end

@implementation CHCardView {
    NSInteger _itemViewCount;
}

- (void)deleteTheTopItemViewWithLeft:(BOOL)left {
    CHCardItemView *itemView = (CHCardItemView *)self.subviews.lastObject;
    [itemView removeWithLeft:left];
}

- (void)reloadData {
    
    if (_dataSource == nil) {
        return ;
    }
    
    // 1. 移除
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2. 创建
    _itemViewCount = [self numberOfItemViews];
    for (int i = 0; i < _itemViewCount; i++) {
        
        CGSize size = [self itemViewSizeAtIndex:i];
        
        CHCardItemView *itemView = [self itemViewAtIndex:i];
        [self addSubview:itemView];
        itemView.delegate = self;
        
        itemView.frame = CGRectMake(self.frame.size.width / 2.0 - size.width / 2.0, self.frame.size.height / 2.0 - size.height / 2.0, size.width, size.height);
        itemView.tag = i + 1;
        itemView.transform = CGAffineTransformMakeTranslation(self.frame.size.width +  500, 400);
        [UIView animateKeyframesWithDuration:0.15 delay:0.05 * i options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            CGAffineTransform scaleTransfrom = CGAffineTransformMakeScale(1 - 0.005 * (10 - i), 1);
            itemView.transform = CGAffineTransformTranslate(scaleTransfrom, 0, 0.5 * (10 - i));
        } completion:nil];
        itemView.userInteractionEnabled = YES;
        [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestHandle:)]];
    }
}

- (CGSize)itemViewSizeAtIndex:(NSInteger)index {
    
    if ([self.dataSource respondsToSelector:@selector(cardView:sizeForItemViewAtIndex:)] && index < [self numberOfItemViews]) {
        CGSize size = [self.dataSource cardView:self sizeForItemViewAtIndex:index];
        if (size.width > self.frame.size.width || size.width == 0) {
            size.width = self.frame.size.width;
        } else if (size.height > self.frame.size.height || size.height == 0) {
            size.height = self.frame.size.height;
        }
        return size;
    }
    return self.frame.size;
}

- (CHCardItemView *)itemViewAtIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(cardView:itemViewAtIndex:)]) {
        CHCardItemView *itemView = [self.dataSource cardView:self itemViewAtIndex:index];
        if (itemView == nil) {
            return [[CHCardItemView alloc] init];
        } else {
            return itemView;
        }
    }
    return [[CHCardItemView alloc] init];
}

- (NSInteger)numberOfItemViews {
    if ([self.dataSource respondsToSelector:@selector(numberOfItemViewsInCardView:)]) {
        return [self.dataSource numberOfItemViewsInCardView:self];
    }
    return 0;
}

- (void)tapGestHandle:(UITapGestureRecognizer *)tapGest {
    if ([self.delegate respondsToSelector:@selector(cardView:didClickItemAtIndex:)]) {
        [self.delegate cardView:self didClickItemAtIndex:tapGest.view.tag - 1];
    }
}

- (void)cardItemViewDidRemoveFromSuperView:(CHCardItemView *)cardItemView {
    if (_itemViewCount > 0) {
        _itemViewCount -= 1;
        if (_itemViewCount == 0) {
            if ([self.dataSource respondsToSelector:@selector(cardViewNeedMoreData:)]) {
                [self.dataSource cardViewNeedMoreData:self];
            }
        }
    }
}

@end
