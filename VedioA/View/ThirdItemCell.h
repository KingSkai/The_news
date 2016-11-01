//
//  ThirdItemCell.h
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdItem.h"

@interface ThirdItemCell : UITableViewCell

@property(nonatomic, retain)UILabel *name;
@property(nonatomic, retain)ThirdItem *t;
@property(retain, nonatomic)UIImageView *voice;

@end
