//
//  FistCollectionViewCell.m
//  音频播放
//
//  Created by 王&甄 on 15/7/22.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "FistCollectionViewCell.h"

@implementation FistCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc]init];
        self.title.backgroundColor = [UIColor whiteColor];
        self.title.alpha = 0.5;
        [self.contentView addSubview:self.title];
 
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.title release];
        [self.title setFont:[UIFont systemFontOfSize:15]];
        
        self.img = [[UIImageView alloc]init];
        self.img.backgroundColor = [UIColor blackColor];
        //[self.img setImage:[UIImage imageNamed:@"fun.jpg"]];
        [self.contentView addSubview:self.img];
        [self.img release];
    }
    return self;
    
    
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    self.img.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height - 40);
    self.title.frame  = CGRectMake(0, self.img.bounds.size.height,layoutAttributes.size.width , 20);
}

- (void)setFstItem:(FirstItem *)fstItem{
    _fstItem = fstItem;
    FirstItem *fstItemm = [[FirstItem alloc]init];
    _fstItem = fstItem;
    self.title.text =fstItemm.name;
}
@end
