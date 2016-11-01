//
//  BigImageCell.h
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "BigImageCollectionViewcell.h"
@protocol pushDelegate <NSObject>


- (void)pushViewController;


@end


@interface BigImageCell : UITableViewCell

//@property (strong, nonatomic) IBOutlet UIImageView *bigImg;
//@property (strong, nonatomic) IBOutlet UILabel *BigImagetitle;

@property(nonatomic, retain)UIImageView *bigImg;
@property(nonatomic, retain)UILabel *BigImagetitle;
@property(nonatomic, retain)NewsModel *nm;
@property(nonatomic, retain)UICollectionView *view;
@property(nonatomic, retain)UICollectionView *collectview;
@property(nonatomic, retain)NSMutableArray *arr;
@property(nonatomic, retain)NSString *urlString;
@property(nonatomic, retain)NSMutableArray *arrayList1;
@property(nonatomic, retain)NSMutableArray *arrayList2;
@property(nonatomic, retain)NSMutableArray *temarr1;

@property(nonatomic, retain)BigImageCollectionViewcell *bigcell;
@property(nonatomic, assign)id<pushDelegate>Mydelegate;

@property(nonatomic, assign)NSInteger *nbrPage;



@end
