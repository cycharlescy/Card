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
    
    // 随机切换..
    NSInteger random = arc4random_uniform(1000);
    if (random % 2 == 0) {
        //  本地数据
            [self.dataArray removeAllObjects];
            for (int i = 0; i < 10; i++) {
                CHCardItemModel *itemModel = [[CHCardItemModel alloc] init];
                itemModel.localImagename = [NSString stringWithFormat:@"%d.jpg", i + 1];
                [self.dataArray addObject:itemModel];
            }
    } else {
        
        // 网络数据
        [self.dataArray removeAllObjects];
        
        NSArray *urls = @[
                          @"http://photo.enterdesk.com/2010-10-24/enterdesk.com-3B11711A460036C51C19F87E7064FE9D.jpg",
                          @"http://img3.redocn.com/tupian/20150411/shouhuixiantiaopingguoshiliang_4042458.jpg",
                          @"http://pic28.nipic.com/20130424/11588775_115415688157_2.jpg",
                          @"http://www.274745.cc/imgall/obuwgnjonzuxa2ldfzrw63i/20100121/1396946_104643942888_2.jpg",
                          @"http://bizhi.zhuoku.com/2011/01/09/jingxuan/Jingxuan263.jpg",
                          @"http://img.taopic.com/uploads/allimg/131113/235002-13111309532260.jpg",
                          @"http://pic54.nipic.com/file/20141204/19902974_135858226000_2.jpg"
                          ];
        
        for (NSString *url in urls) {
            CHCardItemModel *itemModel = [[CHCardItemModel alloc] init];
            itemModel.imagename = url;
            [self.dataArray addObject:itemModel];
        }
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
