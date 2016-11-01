//
//  BigImageCollectionViewcell.m
//  ExploreWorld
//
//  Created by dlios on 15-7-14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "BigImageCollectionViewcell.h"
#import "UIImageView+WebCache.h"

@implementation BigImageCollectionViewcell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.BigImagetitle = [[UILabel alloc]init];
        [self.contentView addSubview:self.BigImagetitle];
        [self.BigImagetitle sizeToFit];
        [self.BigImagetitle release];
        self.BigImagetitle.backgroundColor = [UIColor whiteColor];
        [self.BigImagetitle setFont:[UIFont boldSystemFontOfSize:15]];
        
        self.bigImg = [[UIImageView alloc]init];
        [self.contentView addSubview:self.bigImg];
        self.bigImg.backgroundColor = [UIColor whiteColor];
        [self.bigImg release];
        
        self.picImg = [[UIImageView alloc]init];
        [self.contentView addSubview:self.picImg];
        self.picImg.backgroundColor = [UIColor clearColor];
        [self.picImg setImage:[UIImage imageNamed:@"pic.png"]];
        [self.picImg release];

        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rectB = CGRectMake(0, 0,self.contentView.frame.size.width,200);
    self.bigImg.frame = rectB;
    CGRect rectA = CGRectMake(10, self.bigImg.frame.size.height-10, self.contentView.frame.size.width - 60, 40);
    self.BigImagetitle.frame = rectA;
    
    self.picImg.frame = CGRectMake(self.contentView.frame.size.width - 30, self.bigImg.frame.size.height + 5, 15, 15);


}

- (void)setNm:(NewsModel *)nm{
    _nm = nm;
  //  [self.bigImg sd_setImageWithURL:[NSURL URLWithString:nm.imgsrc]];
    self.BigImagetitle.text = nm.title;
   // NSInteger i = arc4random() % 8 ;
    [self.bigImg sd_setImageWithURL:[NSURL URLWithString:nm.imgsrc] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];

    
}

@end
