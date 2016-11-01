//
//  BigImageCell.m
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "BigImageCell.h"
#import "UIImageView+WebCache.h"

#import "NetWorkTools.h"

@implementation BigImageCell
- (void)dealloc
{
    [_BigImagetitle release];
    [_bigImg release];
    [super dealloc];
}

- (void)awakeFromNib {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 245);
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 210) collectionViewLayout:layout];
        self.collectview.pagingEnabled = YES;
        self.collectview.showsHorizontalScrollIndicator = NO;
        self.collectview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectview.backgroundColor = [UIColor whiteColor];
        [self.collectview registerClass:[BigImageCollectionViewcell class]
             forCellWithReuseIdentifier:@"BigImageCollectionViewcell"];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.contentView addSubview:self.collectview];
        [self.collectview reloadData];
        [self.contentView release];

         
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.Mydelegate pushViewController];
}

@end
