//
//  SetCell.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (void)dealloc
{
    [_label release];
    [_image release];
    [_backView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        [_label release];
        
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:self.image];
        [_image release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(50, 10, 100, 25);
}

// 自定义分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:0.6].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, -1, rect.size.width - 50, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:0.6].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width - 50, 1));

    

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
