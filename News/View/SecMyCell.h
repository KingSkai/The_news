//
//  SecMyCell.h
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "ListenModel.h"

@interface SecMyCell : UITableViewCell
@property(nonatomic, retain)UIImageView *secImg;
@property(nonatomic, retain)UILabel *secTitle;
@property(nonatomic, retain)UILabel *Intro;
@property(nonatomic, retain)UIImageView *timeImg;
@property(nonatomic, retain)UILabel *postTime;
@property(nonatomic, retain)UIImageView *sourceImg;
@property(nonatomic, retain)UILabel *source;

@property(nonatomic, retain)UIButton *alloctedimg;

@property(nonatomic, retain)NewsModel *newsmodel;
@property (nonatomic,retain)ListenModel *model;

@end
