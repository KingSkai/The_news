//
//  ThirdMyCell.m
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ThirdMyCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@implementation ThirdMyCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.third1Img = [[UIImageView alloc]init];
    self.third1Img.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.third1Img];
    [self.third1Img release];
    
    self.third2Img = [[UIImageView alloc]init];
    self.third2Img.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.third2Img];
    [self.third2Img release];
    
    self.third3Img = [[UIImageView alloc]init];
    [self.contentView addSubview:self.third3Img];
    self.backgroundColor = [UIColor whiteColor];
    [self.third3Img release];
    
    self.thirdTitle = [[UILabel alloc]init];
    [self.contentView addSubview:self.thirdTitle];
    self.thirdTitle.backgroundColor = [UIColor whiteColor];
    [self.thirdTitle setFont:[UIFont boldSystemFontOfSize:17]];
    [self.thirdTitle release];
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.thirdTitle.frame = CGRectMake(5, 10, self.contentView.frame.size.width - 20, 30);
    self.third1Img.frame = CGRectMake(5, self.thirdTitle.frame.size.height + 10  + 5,(self.contentView.frame.size.width - 20) / 3 , 90);
    self.third2Img.frame = CGRectMake(self.third1Img.frame.size.width + 5 + 5, self.thirdTitle.frame.size.height + 10  + 5, (self.contentView.frame.size.width - 20) / 3, 90);
    self.third3Img.frame = CGRectMake(self.third1Img.frame.size.width + self.third2Img.frame.size.width + 5 + 5 + 5, self.thirdTitle.frame.size.height + 10  + 5, (self.contentView.frame.size.width - 20) / 3, 90);
    
}
- (void)awakeFromNib {
    
}
- (void)setNm:(NewsModel *)nm{
    _nm = nm;
//    [self.third1Img sd_setImageWithURL:[NSURL URLWithString:nm.imgsrc]];
//    [self.third2Img sd_setImageWithURL:[NSURL URLWithString:nm.imgextra[0][@"imgsrc"]]];
//    [self.third3Img sd_setImageWithURL:[NSURL URLWithString:nm.imgextra[1][@"imgsrc"]]];
   // NSInteger i = arc4random() % 8 ;
    [self.third1Img sd_setImageWithURL:[NSURL URLWithString:nm.imgsrc] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
    
    
    //    [self.third2Img sd_setImageWithURL:[NSURL URLWithString:nm.imgextra[0][@"imgsrc"]]];
    
    
    //NSInteger i1 = arc4random() % 8 ;
    [self.third2Img sd_setImageWithURL:[NSURL URLWithString:nm.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
    
    
    
    //NSInteger i2 = arc4random() % 8 ;
    [self.third3Img sd_setImageWithURL:[NSURL URLWithString:nm.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
    self.thirdTitle.text = nm.title;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
