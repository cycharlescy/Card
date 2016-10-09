//
//  CHCardItemCustomView.m
//  CHCardView
//
//  Created by yaoxin on 16/10/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "CHCardItemCustomView.h"
#import "CHCardItemModel.h"
#import "NSString+MD5.h"

@interface CHCardItemCustomView ()
@property (nonatomic, weak) UIImageView *imgView;
@end

@implementation CHCardItemCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setItemModel:(CHCardItemModel *)itemModel {
    _itemModel = itemModel;
    
    if (itemModel.imagename) {
        NSString *imagename = itemModel.imagename;
        
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[imagename md5]];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data.length > 0) {
            UIImage *image = [UIImage imageWithData:data];
            self.imgView.image = image;
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagename]];
                if (data != nil) {
                    
                  BOOL suc = [data writeToFile:filePath atomically:YES];
                    if (suc) {
                        NSLog(@"存储成功");
                    } else {
                        NSLog(@"存储失败");
                    }
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imgView.image = image;
                    });
                }
                
            });
        }
        
        
    } else if (itemModel.localImagename) {
        self.imgView.image = [UIImage imageNamed:itemModel.localImagename];
    }
    
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
