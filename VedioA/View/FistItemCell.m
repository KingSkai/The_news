//
//  FistItemCell.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "FistItemCell.h"

@implementation FistItemCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setFstItem:(FirstItem *)fstItem{
    FirstItem *fstItemm = [[FirstItem alloc]init];
    _fstItem = fstItem;
    self.title.text =fstItemm.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_title release];
    [super dealloc];
}
@end
