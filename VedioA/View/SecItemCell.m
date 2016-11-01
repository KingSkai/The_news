//
//  SecItemCell.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "SecItemCell.h"

@implementation SecItemCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.name = [[UILabel alloc]init];
    self.name.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.name];
    [self.name setFont:[UIFont boldSystemFontOfSize:18]];
    [self.name release];
    
    self.displayment = [[UILabel alloc]init];
    self.displayment.backgroundColor  = [UIColor clearColor];
    [self.contentView addSubview:self.displayment];
    [self.displayment release];
    
    
    self.desc  = [[UILabel alloc]init];
    self.desc.backgroundColor = [UIColor clearColor];
    self.desc.numberOfLines = 2;
    [self.desc sizeToFit];
    [self.contentView addSubview:self.desc];
    [self.desc release];
    
    self.imgA = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imgA];
    [self.imgA setImage:[UIImage imageNamed:@"iconfont-biaoti-1"]];
    [self.imgA release];
    
    self.imgD = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imgD];
    [self.imgD setImage:[UIImage imageNamed:@"iconfont-xiangxineirong"]];
    [self.imgD release];
    
    self.imgindi = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imgindi];
    [self.imgindi setImage:[UIImage imageNamed:@"iconfont-youyou"]];
    [self.imgindi release];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.name.frame = CGRectMake(40, 10, self.contentView.frame.size.width - 50, 30);
    self.displayment.frame = CGRectMake(40, self.name.bounds.size.height + 10, self.contentView.frame.size.width - 50, 30);
    self.desc.frame = CGRectMake(40, self.name.bounds.size.height + 10 + 30, self.contentView.frame.size.width - 70, 60);
    self.imgA.frame = CGRectMake(5, 15, 20, 20);
    self.imgD.frame = CGRectMake(5, self.name.bounds.size.height + 10 + 50, 20, 20);
    self.imgindi.frame = CGRectMake(self.frame.size.width - 30, self.contentView.frame.size.height / 2 - 10, 20, 20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setS:(SecItem *)s{
    _s = s;
    self.name.text = s.name;
    self.displayment.text = s.displayname;
    self.desc.text = s.desc;
}

@end