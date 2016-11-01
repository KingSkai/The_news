//
//  ReadCell.m
//  ExploreWorld
//
//  Created by 王凯 on 15/7/14.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ReadCell.h"
#import "UIImageView+WebCache.h"
#import "DataBaseManager.h"



@implementation ReadCell


- (void)dealloc
{
    [_img release];
    [_labelForSummary release];
    [_viewDown release];
    [_replies_count release];
    [_commentImage release];
    [_created_at release];
    [_dateImage release];
    [_read_collect release];
    [_hoderImg release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // 调用父类初始化
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.img = [[UIImageView alloc] init];
        [self.contentView addSubview:self.img];
        [_img release];
        
        self.labelForSummary = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelForSummary];
        [_labelForSummary release];
        
        self.viewDown = [[UIView alloc] init];
        [self.contentView addSubview:self.viewDown];
        [_viewDown release];
        
        self.replies_count = [[UILabel alloc] init];
        [_replies_count release];
        
        self.commentImage = [[UIImageView alloc] init];
        [_commentImage release];
        
        self.created_at = [[UILabel alloc] init];
        [self.viewDown addSubview:self.created_at];
        [_created_at release];
        
        self.dateImage = [[UIImageView alloc] init];
        [self.viewDown addSubview:self.dateImage];
        [_dateImage release];
        
        self.read_collect = [[ReadCollectButton alloc] init];
        [self.viewDown addSubview:self.read_collect];
        [_read_collect release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.img.frame = CGRectMake(10, 10, 120, self.contentView.bounds.size.height - 20);

    self.labelForSummary.numberOfLines = 0;
    self.labelForSummary.adjustsFontSizeToFitWidth = NO;
    [self.labelForSummary setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    
    self.viewDown.frame = CGRectMake(115 + 20, 80, self.contentView.bounds.size.width - 20 - 120, 20);
    self.replies_count.frame = CGRectMake(self.viewDown.frame.size.width - 20, 1, 30, self.viewDown.frame.size.height);
    self.replies_count.font = [UIFont systemFontOfSize:15];
    [self.replies_count setTextColor:[UIColor grayColor]];
    
    self.commentImage.frame = CGRectMake(self.viewDown.frame.size.width - 40, 4, 16, 16);
    
    self.created_at.frame = CGRectMake(25, 2, 80, self.viewDown.frame.size.height);
    self.created_at.font = [UIFont systemFontOfSize:14];
    [self.created_at setTextColor:[UIColor grayColor]];
    
    self.dateImage.frame = CGRectMake(5, 4, 15, 15);
    self.read_collect.frame = CGRectMake(110, 3, 15, 15);
}


- (CGFloat)hightWithText:(NSString *)text
{
    
    // 设置一个字典 保存文本属性
    // 保存文本字体大小, 和lable设置的大小一致
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    // 预设一个尺寸大小 文本最大不超过这个尺寸(高度 设置的尽可能大)
    CGSize size = CGSizeMake ([UIScreen mainScreen].bounds.size.width - 140, 100);
    // 根据文本内容 获得一个CGRect
    // 参数 1: 尺寸范围 (size - 包括 wight, hight)
    // 参数 2: 按照什么方式获取Rect
    // 参数 3: 文本属性
    // 参数 4: nil
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];

    return rect.size.height;
}

- (void)setModel:(ReadModel *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    CGFloat hight = [self hightWithText:model.title];
    self.labelForSummary.frame = CGRectMake(115 + 25, 10, [UIScreen mainScreen].bounds.size.width - 130 - 20, hight);
    self.read_collect.readModel = model;
    
    self.labelForSummary.text = model.title;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.feature_img] placeholderImage:[UIImage imageNamed:@"holder3"]];

    self.replies_count.text = [model.replies_count description];
    [self.viewDown addSubview:self.replies_count];
    self.commentImage.image = [UIImage imageNamed:@"pinglun_hui"];
    [self.viewDown addSubview:self.commentImage];
    
    // 时间
    NSString *str = [model.created_at substringWithRange:NSMakeRange(5, 14)];
    NSArray *monthArr = [str componentsSeparatedByString:@"-"];
    NSString *monthStr = monthArr[0];
    NSString *day = [monthArr[1] substringWithRange:NSMakeRange(0, 2)];
    NSString *time = [monthArr[1] substringWithRange:NSMakeRange(3, 5)];
    NSString *creatTime = [NSString stringWithFormat:@"%@-%@ %@", monthStr, day, time];
    self.created_at.text = creatTime;
    
    self.dateImage.image = [UIImage imageNamed:@"shijian_hui"];
    [self.read_collect addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    CollectModel *collect = [[CollectModel alloc] init];
    collect.title = model.title;
    [self.read_collect setImage:[UIImage imageNamed:@"read_collect"] forState:UIControlStateNormal];
    NSMutableArray *arr = [dbManager  selectInfoFromNewsCollect];
    for (CollectModel *m in arr) {
        if ([m.title isEqualToString:collect.title]) {
            [self.read_collect setImage:[UIImage imageNamed:@"read_collect_cancel"] forState:UIControlStateNormal];
            
        }
    }
    
}

// 收藏点击方法
- (void)touch:(id)sender
{
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    CollectModel *collect = [[CollectModel alloc]init];
    collect.ima = self.read_collect.readModel.feature_img;
    collect.title = self.read_collect.readModel.title;

    // 用于收藏返回
    collect.feed_id = self.read_collect.readModel.feed_id;
    NSMutableArray *arr = [dbManager  selectInfoFromNewsCollect];
    for (CollectModel *m  in arr) {
        if ([m.title isEqualToString:collect.title]) {
            [dbManager deleteInfoFromNewsCollectWithTitle:collect.title];
            [self.read_collect setImage:[UIImage imageNamed:@"read_collect"] forState:UIControlStateNormal];
            return;
        }
    }
    [dbManager insertInfoWithNewsCollect:collect];
    [self.read_collect setImage:[UIImage imageNamed:@"read_collect_cancel"] forState:UIControlStateNormal];

}

// 自定义分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:0.5].CGColor);
    CGContextStrokeRect(context, CGRectMake(40, -1, rect.size.width - 50, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:0.5].CGColor);
    CGContextStrokeRect(context, CGRectMake(40, rect.size.height, rect.size.width - 50, 1));
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
