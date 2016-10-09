//
//  ViewController.m
//  CARD
//
//  Created by yaoxin on 16/10/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "ViewController.h"
#import "CHCardView.h"
#import "CHCardItemCustomView.h"
#import "CHCardItemModel.h"

@interface ViewController () <CHCardViewDelegate, CHCardViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) CHCardView *cardView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up views
    [self setUpViews];
    
    // data
    [self loadData];
    
    // reload
    [self.cardView reloadData];
}

- (void)setUpViews {
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.cardView.frame.origin.x, self.cardView.frame.origin.y + self.cardView.frame.size.height + 30, 60, 30)];
    [self.view addSubview:leftBtn];
    [leftBtn setTitle:@"不喜欢" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(disLikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0 - leftBtn.frame.size.width / 2.0, leftBtn.frame.origin.y, leftBtn.frame.size.width, leftBtn.frame.size.height)];
    [self.view addSubview:centerBtn];
    [centerBtn setTitle:@"重置" forState:UIControlStateNormal];
    centerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [centerBtn addTarget:self action:@selector(resetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.cardView.frame.origin.x + self.cardView.frame.size.width - leftBtn.frame.size.width, leftBtn.frame.origin.y, leftBtn.frame.size.width, leftBtn.frame.size.height)];
    [self.view addSubview:rightBtn];
    [rightBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)disLikeBtnClick:(UIButton *)btn {
    [self.cardView deleteTheTopItemViewWithLeft:YES];
}

- (void)resetBtnClick:(UIButton *)btn {
    
    [self loadData];
    
    [self.cardView reloadData];
}

- (void)likeBtnClick:(UIButton *)btn {
    [self.cardView deleteTheTopItemViewWithLeft:NO];
}

// data
- (void)loadData {
    [self.dataArray removeAllObjects];
    for (int i = 0; i < 10; i++) {
        CHCardItemModel *itemModel = [[CHCardItemModel alloc] init];
        itemModel.localImagename = [NSString stringWithFormat:@"%d.jpg", i + 1];
        [self.dataArray addObject:itemModel];
    }
}

#pragma mark - CHCardViewDelegate
- (NSInteger)numberOfItemViewsInCardView:(CHCardView *)cardView {
    return self.dataArray.count;
}

- (CHCardItemView *)cardView:(CHCardView *)cardView itemViewAtIndex:(NSInteger)index {
    CHCardItemCustomView *itemView = [[CHCardItemCustomView alloc] initWithFrame:cardView.bounds];
    itemView.itemModel = self.dataArray[index];
    return itemView;
}

- (void)cardViewNeedMoreData:(CHCardView *)cardView {
    
    // data
    [self loadData];
    
    // reload
    [self.cardView reloadData];
}

// select
- (void)cardView:(CHCardView *)cardView didClickItemAtIndex:(NSInteger)index { }

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (CHCardView *)cardView {
    if (!_cardView) {
        CHCardView *cardView = [[CHCardView alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width - 40, 400)];
        [self.view addSubview:cardView];
        _cardView = cardView;
        cardView.delegate = self;
        cardView.dataSource = self;
    }
    return _cardView;
}

@end
