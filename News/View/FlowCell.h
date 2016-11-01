//
//  FlowCell.h
//  segment
//
//  Created by 王凯 on 15/7/13.
//  Copyright (c) 2015年 王凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowModel.h"

@interface FlowCell : UICollectionViewCell

@property (nonatomic, retain) FlowModel *model;
@property (nonatomic, retain) UIImageView *img;

@end
