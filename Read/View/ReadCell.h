//
//  ReadCell.h
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
#import "ReadCollectButton.h"


@interface ReadCell : UITableViewCell

@property (nonatomic, retain) UIImageView *img;
@property (nonatomic, retain) UIImageView *hoderImg;
@property (nonatomic, retain) UILabel *nameLable;
@property (nonatomic, retain) UILabel *labelForSummary;
@property (nonatomic, retain) UIView *viewDown;
@property (nonatomic, retain) UILabel *replies_count;
@property (nonatomic, retain) UIImageView *commentImage;
@property (nonatomic, retain) UILabel *created_at;
@property (nonatomic, retain) UIImageView *dateImage;
@property (nonatomic, retain) ReadCollectButton *read_collect;
@property (nonatomic, retain) ReadModel *model;
@property (nonatomic, retain) NSMutableArray *buttonArr;

// 自适应
- (CGFloat)hightWithText:(NSString *)text;


@end
