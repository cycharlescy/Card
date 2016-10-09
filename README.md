
###更多内容请移步至简书：简书地址：[简书地址](http://www.jianshu.com/users/3930920b505b/latest_articles) 
####Gif展示 

![8.gif](http://upload-images.jianshu.io/upload_images/939127-47e6bca543d3b027.gif?imageMogr2/auto-orient/strip)

#####主要代码：CHCardView.h
```
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
```
#####主要代码：CHCardView.m
```
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
        itemView.transform = CGAffineTransformMakeTranslation(self.frame.size.width +  500, 400);
        [UIView animateKeyframesWithDuration:0.15 delay:0.05 * i options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            CGAffineTransform scaleTransfrom = CGAffineTransformMakeScale(1 - 0.005 * (10 - i), 1);
            itemView.transform = CGAffineTransformTranslate(scaleTransfrom, 0, 0.5 * (10 - i));
        } completion:nil];
        itemView.userInteractionEnabled = YES;
        [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestHandle:)]];
    }
}
```
#####主要代码
```
  if (panGest.state == UIGestureRecognizerStateChanged) {
        
        CGPoint movePoint = [panGest translationInView:self];
        _isLeft = (movePoint.x < 0);
        
        self.center = CGPointMake(self.center.x + movePoint.x, self.center.y + movePoint.y);
        
        CGFloat angle = (self.center.x - self.frame.size.width / 2.0) / self.frame.size.width * 0.5;
        _currentAngle = angle;
        self.transform = CGAffineTransformMakeRotation(angle);
         
        [panGest setTranslation:CGPointZero inView:self];
        
    } else if (panGest.state == UIGestureRecognizerStateEnded) {
        
        CGPoint vel = [panGest velocityInView:self];
        if (vel.x > 400 || vel.x < - 400) {
            [self remove];
            return ;
        }
        if (self.frame.origin.x + self.frame.size.width > 100 && self.frame.origin.x < self.frame.size.width - 100) {
            [UIView animateWithDuration:0.3 animations:^{
                self.center = _originalCenter;
                self.transform = CGAffineTransformMakeRotation(0);
            }];
        } else {
            [self remove];
        }
    }
```
###更多内容请移步至简书：简书地址：[简书地址](http://www.jianshu.com/users/3930920b505b/latest_articles) 
