//
//  SecMyCell.m
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SecMyCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "DataBaseManager.h"
#import "CollectModel.h"
@implementation SecMyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
 
        self.secImg = [[UIImageView alloc]init];
        [self.contentView addSubview:self.secImg];
        [self.secImg setBackgroundColor:[UIColor whiteColor]];
        [self.secImg release];
        
        self.secTitle = [[UILabel alloc]init];
        [self.contentView addSubview:self.secTitle];
        [self.secTitle setBackgroundColor:[UIColor whiteColor]];
        [self.secTitle release];
        [self.secTitle setFont:[UIFont boldSystemFontOfSize:17]];
        
        self.Intro = [[UILabel alloc]init];
        [self.contentView addSubview:self.Intro];
        [self.Intro setBackgroundColor:[UIColor whiteColor]];
        self.Intro.numberOfLines = 2;
        [self.Intro sizeToFit];
        [self.Intro setFont:[UIFont systemFontOfSize:14]];
        [self.Intro release];
        [self.Intro setTextColor:[UIColor grayColor]];
    
        self.timeImg = [[UIImageView alloc]init];
        [self.contentView addSubview:self.timeImg];
        self.timeImg.backgroundColor  = [UIColor whiteColor];
        [self.timeImg release];
    
        self.postTime = [[UILabel alloc]init];
        [self.contentView addSubview:self.postTime];
        [self.postTime setBackgroundColor:[UIColor whiteColor]];
        [self.postTime release];
        [self.postTime setFont:[UIFont systemFontOfSize:13]];
        [self.postTime setTextColor:[UIColor grayColor]];
    
    self.sourceImg = [[UIImageView alloc]init];
    self.sourceImg.image = [UIImage imageNamed:@"resource"];
    [self.contentView addSubview:self.sourceImg];
    [self.sourceImg release];
    
    self.source = [[UILabel alloc]init];
    self.source.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.source];
    [self.source release];
    [self.source setFont:[UIFont systemFontOfSize:13]];
    [self.source setTextColor:[UIColor grayColor]];
    
    self.alloctedimg = [[UIButton alloc]init];
    self.alloctedimg.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.alloctedimg];
    [self.alloctedimg release];
    
    
    
    return self;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.secImg.frame = CGRectMake(10, 5, self.contentView.frame.size.width - 255, 90);
    self.secTitle.frame = CGRectMake(self.secImg.frame.size.width + 10 + 5, 5, 230, 20);
    self.Intro.frame = CGRectMake(self.secImg.frame.size.width + 10 + 5 ,5 + self.secTitle.frame.size.height, 230, 50);
    self.timeImg.frame = CGRectMake(self.secImg.frame.size.width + 10 + 5 + 2,self.Intro.frame.size.height + 5 + 20 + 2, 15, 15);
    self.postTime.frame = CGRectMake(self.secImg.frame.size.width + 5 + 5 + 20 + 5, self.Intro.frame.size.height + 5 + 20, 100, 20);
    self.sourceImg.frame = CGRectMake(self.contentView.frame.size.width - 110 + 2, self.Intro.frame.size.height + 5 + 20 + 2, 13, 13);
    self.source.frame = CGRectMake(self.contentView.frame.size.width - 90, self.Intro.frame.size.height + 5 + 20, 80, 20);
    self.alloctedimg.frame = CGRectMake(self.contentView.frame.size.width - 143, self.Intro.frame.size.height + 5 + 20, 18, 18);
    [self.alloctedimg addTarget:self action:@selector(actionTap:) forControlEvents:UIControlEventTouchUpInside];
    
    //判断是否存在数据库
    DataBaseManager *dbManger = [DataBaseManager shareInstance];
    [dbManger openDB];
    NSMutableArray *arr = [dbManger selectInfoFromNewsCollect];
    for (CollectModel *m in arr) {
        if ([self.newsmodel.title isEqualToString:m.title]) {
            [self.alloctedimg setImage:[UIImage imageNamed:@"hasAllocate"] forState:UIControlStateNormal];
        }else{
            [self.alloctedimg setImage:[UIImage imageNamed:@"Allocate"] forState:UIControlStateNormal];
        }
    }
    
    
}
- (void)actionTap:(id *)sender{
    DataBaseManager *dbManger = [DataBaseManager shareInstance];
    [dbManger openDB];
    CollectModel *coll = [[CollectModel alloc]init];
    coll.ima = self.newsmodel.imgsrc;
    coll.title = self.newsmodel.title;
//    coll.url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", self.newsmodel.docid];
    coll.url = self.newsmodel.docid;
    NSMutableArray *arr = [dbManger selectInfoFromNewsCollect];
    for (CollectModel *m in arr) {
        if ([m.title isEqualToString:coll.title]) {
            [dbManger deleteInfoFromNewsCollectWithTitle:coll.title];
            [self.alloctedimg setImage:[UIImage imageNamed:@"Allocate"] forState:UIControlStateNormal];
            self.model.collectioned = NO;
            return;
        
        }
    }
    self.model.collectioned = YES;
    
    [dbManger insertInfoWithNewsCollect:coll];
    [self.alloctedimg setImage:[UIImage imageNamed:@"hasAllocate"] forState:UIControlStateNormal];
    
    
}

- (void)awakeFromNib {
  
}
- (void)setNewsmodel:(NewsModel *)newsmodel{
    _newsmodel = newsmodel;
    self.secTitle.text = self.newsmodel.title;
 //   [self.secImg sd_setImageWithURL:[NSURL URLWithString:self.newsmodel.imgsrc]];
   // NSInteger i = arc4random() % 8 ;
    [self.secImg sd_setImageWithURL:[NSURL URLWithString:self.newsmodel.imgsrc] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"holder%d", 3]]];
    self.Intro.text = self.newsmodel.digest;
    self.timeImg.image = [UIImage imageNamed:@"timeP"];
    [self.alloctedimg setImage:[UIImage imageNamed:@"Allocate"] forState:UIControlStateNormal];
    [self.alloctedimg setImage:[UIImage imageNamed:@"hasAllocate"] forState:UIControlStateSelected];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
