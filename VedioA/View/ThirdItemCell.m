//
//  ThirdItemCell.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "ThirdItemCell.h"

@implementation ThirdItemCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.name = [[UILabel alloc]init];
        self.name.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.name];
        [self.name release];
        self.name.numberOfLines = 2;
        //[self.name sizeToFit];
        self.voice = [[UIImageView alloc]init];
        [self.contentView addSubview:self.voice];
        [self.voice setImage:[UIImage imageNamed:@"iconfont-broadcast"]];
        [self.voice release];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.name.frame = CGRectMake(40, self.contentView.frame.size.height / 2 - 30, self.contentView.frame.size.width - 70, 60);

    self.voice.frame = CGRectMake(10, self.contentView.frame.size.height / 2 - 10, 20, 20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setT:(ThirdItem *)t{
    _t = t;
   
    self.name.text = t.name;
    
}

- (void)dealloc {
    [_name release];
    [super dealloc];
}
@end
