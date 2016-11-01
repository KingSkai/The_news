//
//  ListenNormalTableViewCell.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ListenNormalTableViewCell.h"
#import "DataBaseManager.h"


@implementation ListenNormalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildBirmalCell];
    }
    return  self;
}



- (void)buildBirmalCell
{
    float WIDTH = [UIScreen mainScreen].bounds.size.width;
    
    
    //标题图片
    self.cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH , WIDTH / 2)];
    
    [self.cellImage setBackgroundColor:[UIColor grayColor]];
    [self addSubview:self.cellImage];
    [self.cellImage release];
    
    //title
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, WIDTH / 2 + 10 , WIDTH - 60, 20)];
    [self addSubview:self.titleLable];
    [self.titleLable setFont:[UIFont systemFontOfSize:14]];
    UIColor *titleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [self.titleLable setTextColor:titleColor];
    [self.titleLable release];
    
    //收藏
    self.collectButton = [[CollectButton alloc]initWithFrame:CGRectMake(WIDTH - 50,  WIDTH / 2 + 10 , 20, 20)];
    [self addSubview:self.collectButton];
    [self.collectButton addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *start = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [start setCenter:CGPointMake(WIDTH / 2, (WIDTH / 2 + 20)/2)];
     [start setAlpha:0.5];
    [start setClipsToBounds:YES];
    start.layer.cornerRadius = 5;
    [start setImage:[UIImage imageNamed:@"readlyToPlay.png"]];
    [self addSubview:start];
}


- (void)collectClick:(id)sender
{
    
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    CollectModel *coll = [[CollectModel alloc]init];
    coll.ima = self.collectButton.listen.image;
    coll.title = [NSString stringWithFormat:@"%@",self.collectButton.listen.title];
     coll.mediaUrl =   [NSString stringWithFormat:@"http://asp.cntv.lxdns.com/asp/hls/200/0303000a/3/default/%@/200.m3u8",self.collectButton.listen.videoID] ;
    NSMutableArray *arr = [dbManager  selectInfoFromNewsCollect];
    for (CollectModel *m  in arr) {
        if ([m.title isEqualToString:coll.title]) {
            [dbManager deleteInfoFromNewsCollectWithTitle:coll.title];
            [self.collectButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
            self.model.collectioned = NO;
            return;
        }
    }
    self.model.collectioned = YES;
    
    [dbManager insertInfoWithNewsCollect:coll];
    [self.collectButton setImage:[UIImage imageNamed:@"finishshoucang.png"] forState:UIControlStateNormal];
}

@end
