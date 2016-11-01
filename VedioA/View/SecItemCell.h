//
//  SecItemCell.h
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecItem.h"

@interface SecItemCell :UITableViewCell

@property(retain, nonatomic)UILabel *name;
@property(retain, nonatomic)UILabel *displayment;
@property(retain, nonatomic)UILabel *desc;
@property(retain, nonatomic)UIImageView *imgA;
@property(retain, nonatomic)UIImageView *imgD;

@property(retain, nonatomic)UIImageView *imgindi;

@property(nonatomic, retain)SecItem *s;

@end
