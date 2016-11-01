//
//  SubTableViewCell.h
//  The_news
//
//  Created by 王&甄 on 15/7/24.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@interface SubTableViewCell : UITableViewCell
@property(nonatomic, retain)UILabel *titlel;
@property(nonatomic, retain)UIImageView *img;
@property(nonatomic, retain)NewsModel *nm;

@end
