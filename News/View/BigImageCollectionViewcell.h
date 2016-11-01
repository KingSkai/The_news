//
//  BigImageCollectionViewcell.h
//  ExploreWorld
//
//  Created by dlios on 15-7-14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface BigImageCollectionViewcell : UICollectionViewCell
@property(nonatomic, retain)UIImageView *bigImg;
@property(nonatomic, retain)UILabel *BigImagetitle;
@property(nonatomic, retain)NewsModel *nm;
@property(nonatomic, retain)UIImageView *picImg;

@end
