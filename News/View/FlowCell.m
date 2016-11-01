//
//  FlowCell.m
//  segment
//
//  Created by 王凯 on 15/7/13.
//  Copyright (c) 2015年 王凯. All rights reserved.
//

#import "FlowCell.h"

@implementation FlowCell

- (void)dealloc
{
    [super dealloc];
    [_model release];
    [_img release];
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self.contentView addSubview:self.img];
    }
    return self;
}


// 布局frame
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // 显示前执行的方法
    // layoutAttributes 就是item
    self.img.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height);
}

- (void)setImg:(UIImageView *)img
{
    if (img != _img) {
        _img = img;
    }
    [self setNeedsDisplay];
}

@end
