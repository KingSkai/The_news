//
//  BigImageCellB.m
//  ExploreWorld
//
//  Created by dlios on 15-7-15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "BigImageCellB.h"
#import "UIImageView+WebCache.h"
@implementation BigImageCellB

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.Btitle = [[UILabel alloc]init];
        self.Btitle.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.Btitle];
        [self.Btitle release];
        [self.Btitle sizeToFit];
        [self.Btitle setFont:[UIFont boldSystemFontOfSize:15]];
        
        self.bimg = [[UIImageView alloc]init];
        self.bimg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bimg];
        [self.bimg release];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];


    CGRect rectC = CGRectMake(0, 0,self.contentView.frame.size.width,200);
    self.bimg.frame = rectC;
    
    CGRect rectA = CGRectMake(10,self.bimg.frame.size.height, self.contentView.frame.size.width - 20, 30);
    self.Btitle.frame = rectA;
}
- (void)setNm:(NewsModel *)nm{
    _nm = nm;
  //  [self.bimg sd_setImageWithURL:[NSURL URLWithString:self.nm.imgsrc]];
    self.Btitle.text = self.nm.title;
    
   // NSInteger i = arc4random() % 8 ;
    [self.bimg sd_setImageWithURL:[NSURL URLWithString:self.nm.imgsrc] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
