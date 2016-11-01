//
//  myCell.m
//  segment
//
//  Created by 王凯 on 15/7/10.
//  Copyright (c) 2015年 王凯. All rights reserved.
//

#import "myCell.h"

@implementation myCell

- (void)dealloc
{
    [_label release];
    [super dealloc];
    
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
    }
    return self;
}

#pragma mark - 布局frame
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // cell显示前执行的方法
    // layoutAttributes.size 就是itemSize
    self.label.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height);
//    self.label.bounds
    self.label.textAlignment = NSTextAlignmentCenter;
    //self.label.layer.borderWidth = 1;
    [self.label setFont:[UIFont systemFontOfSize:15]];
    //self.label.layer.borderColor = [UIColor yellowColor].CGColor;
}

#pragma mark - 赋值

- (void)setModel:(Model *)model
{
    if (_model != model) {
        [model release];
        _model = [model retain];
    }
    self.label.text = model.name;
}

@end
