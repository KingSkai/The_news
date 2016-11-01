//
//  FistCollectionViewCell.h
//  音频播放
//
//  Created by 王&甄 on 15/7/22.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstItem.h"
@interface FistCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain)UILabel *title;
@property(nonatomic, retain)UIImageView *img;
@property(nonatomic ,retain)FirstItem *fstItem;

@end
