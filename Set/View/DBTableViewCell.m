//
//  DBTableViewCell.m
//  The_news
//
//  Created by dlios on 15/7/19.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DBTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@implementation DBTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc
{
    [self.ima release];
    [self. title release];
    [self.type release];
    [self.model release];
    [super dealloc];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildMyCell];
    }
    return  self;
}



- (void)buildMyCell
{
    UIView *po = [[UIView alloc]initWithFrame:CGRectMake(5,5, WIDTH - 10, 70)];
    [self addSubview:po];
    [po setBackgroundColor:[UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1]];
  [po setClipsToBounds:YES];
    po.layer.cornerRadius = 5;
    
    self.ima = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    [self.ima setBackgroundColor:[UIColor blackColor]];
    [po addSubview:self.ima];
    
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, WIDTH - 80, 30)];
    [self.title setFont:[UIFont systemFontOfSize:14]];
    [po addSubview:self.title];
    
    self.type = [[UIImageView alloc]initWithFrame:CGRectMake(80 , 40, 20, 20)];
    [po addSubview:self.type];
    
    
    
  
 }


@end
