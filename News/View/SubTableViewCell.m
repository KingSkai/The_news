//
//  SubTableViewCell.m
//  The_news
//
//  Created by 王&甄 on 15/7/24.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "SubTableViewCell.h"

@implementation SubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titlel = [[UILabel alloc]init];
        self.titlel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titlel];
        [self.titlel release];
        
        self.img = [[UIImageView alloc]init];
        self.img.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.img];
        [self.img release];

        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titlel.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, 30);
    self.img.frame = CGRectMake(10, self.titlel.frame.size.height + 10, self.contentView.frame.size.width - 20, 80);
}
- (void)setNm:(NewsModel *)nm{
    _nm = nm;
   // [self.img sd_setImageWithURL:[NSURL URLWithString:self.nm.imgsrc]];
    self.titlel.text = self.nm.title;
//    NSInteger i = arc4random() % 8 ;
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.nm.imgsrc] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
