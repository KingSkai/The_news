//
//  PhotoCollectionViewCell.h
//  The_news
//
//  Created by 王&甄 on 15/7/24.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photots.h"
#import "photoDetails.h"
#import "NewsModel.h"
#import "PhotoSetModel.h"

@interface PhotoCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>

@property(nonatomic, retain)UILabel *textlabel;
@property(nonatomic, retain)UILabel *headerLabel;
@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)Photots *photo;
@property(nonatomic, retain)Photodetails *photodetails;

@property(nonatomic, retain)NSMutableArray *getModels;
@property(nonatomic, retain)NewsModel *newsModel;

@property(nonatomic, retain)UIImageView *bigImg;
@property(nonatomic, retain)UILabel *BigImagetitle;
@property(nonatomic, retain)NewsModel *nm;
@property(nonatomic, retain)UIScrollView *scrollview;

@property(nonatomic, retain)PhotoSetModel *ps;

@end
