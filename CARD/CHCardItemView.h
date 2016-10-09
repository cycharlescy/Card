//
//  CHCardItemView.h
//  CHCardView
//
//  Created by yaoxin on 16/10/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHCardItemView, CHCardItemModel;
@protocol CHCardItemViewDelegate <NSObject>
- (void)cardItemViewDidRemoveFromSuperView:(CHCardItemView *)cardItemView;
@end

@interface CHCardItemView : UIView
@property (nonatomic, weak) id <CHCardItemViewDelegate> delegate;

- (void)removeWithLeft:(BOOL)left;
@end
