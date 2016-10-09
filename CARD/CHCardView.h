//
//  CHCardView.h
//  CHCardView
//
//  Created by yaoxin on 16/10/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@class CHCardView, CHCardItemView;
@protocol CHCardViewDelegate <NSObject>
@optional
- (void)cardView:(CHCardView *)cardView didClickItemAtIndex:(NSInteger)index;
@end

@protocol CHCardViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemViewsInCardView:(CHCardView *)cardView;
- (CHCardItemView *)cardView:(CHCardView *)cardView itemViewAtIndex:(NSInteger)index;
- (void)cardViewNeedMoreData:(CHCardView *)cardView;
@optional
// default is equal to cardView's bounds
- (CGSize)cardView:(CHCardView *)cardView sizeForItemViewAtIndex:(NSInteger)index;

@end

@interface CHCardView : UIView
@property (nonatomic, weak) id <CHCardViewDataSource> dataSource;
@property (nonatomic, weak) id <CHCardViewDelegate> delegate;

- (void)deleteTheTopItemViewWithLeft:(BOOL)left;
- (void)reloadData;
@end
