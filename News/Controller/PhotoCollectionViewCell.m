//
//  PhotoCollectionViewCell.m
//  The_news
//
//  Created by 王&甄 on 15/7/24.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@implementation PhotoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
        [self.img setBackgroundColor:[UIColor clearColor]];
        
        self.headerLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.headerLabel];
        [self.headerLabel setBackgroundColor:[UIColor clearColor]];
        [self.headerLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self.headerLabel setTextColor:[UIColor whiteColor]];
        [self.headerLabel sizeToFit];
        
        
        self.scrollview = [[UIScrollView alloc]init];
        self.scrollview.backgroundColor = [UIColor clearColor];
        self.scrollview.pagingEnabled  = NO;
        self.scrollview.contentSize = CGSizeMake(0, 500);
        self.scrollview.scrollsToTop = YES;
        [self.contentView addSubview:self.scrollview];
        [self.scrollview release];
        
        
        self.textlabel = [[UILabel alloc]init];
        [self.scrollview addSubview:self.textlabel];
        self.textlabel.textAlignment = NSTextAlignmentLeft;
        [self.textlabel setBackgroundColor:[UIColor clearColor]];
        [self.textlabel setTextColor:[UIColor whiteColor]];
        [self.textlabel setFont:[UIFont systemFontOfSize:15]];
        self.textlabel.numberOfLines = 20;
        [self sizeToFit];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.img.frame = CGRectMake(0, 30, self.contentView.frame.size.width, self.contentView.frame.size.height - 50 - self.headerLabel.frame.size.height - self.textlabel.frame.size.height - 80 - 100);
    self.headerLabel.frame = CGRectMake(10, self.img.frame.size.height + 30, self.contentView.frame.size.width - 20, 40);
    self.scrollview.frame = CGRectMake(10, self.img.frame.size.height + self.headerLabel.frame.size.height + 30, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - self.img.frame.size.height - self.headerLabel.frame.size.height + 10);
    self.textlabel.frame = CGRectMake(0, 0 , self.scrollview.frame.size.width, [self heightWithText:self.ps.note]);

    
}
- (CGFloat)heightWithText:(NSString *)text
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 1000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
    
}

- (void)setPs:(PhotoSetModel *)ps{
    _ps = ps;
    self.textlabel.text = ps.note;
    [self.img sd_setImageWithURL:[NSURL URLWithString:ps.imgurl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
}
@end
