//
//  ListenNormalTableViewCell.h
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListenModel.h"
#import "CollectButton.h"

@interface ListenNormalTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView *cellImage;
@property (nonatomic,retain)UILabel *titleLable ;
@property (nonatomic,retain)CollectButton *collectButton;
@property (nonatomic,retain)ListenModel *model;

@end
