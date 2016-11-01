//
//  FistItemCell.h
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstItem.h"
@interface FistItemCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property(nonatomic ,retain)FirstItem *fstItem;

@end
