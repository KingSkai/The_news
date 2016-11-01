//
//  DBTableViewCell.h
//  The_news
//
//  Created by dlios on 15/7/19.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
@interface DBTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView *ima;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UIImageView *type;
@property (nonatomic,retain)CollectModel *model;
@end
