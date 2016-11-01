//
//  Headerdetails.m
//  ExploreWorld
//
//  Created by dlios on 15-7-15.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Headerdetails.h"
#import "photoDetails.h"
#import "Photots.h"
#import "NewsModel.h"
#import "NetWorkTools.h"
#import "UIImageView+WebCache.h"
@interface Headerdetails ()
@property(nonatomic, retain)UIButton *button;
@property(nonatomic, retain)UILabel *textlabel;
@property(nonatomic, retain)UILabel *headerLabel;
@property(nonatomic, retain)UIImageView *img;
@property(nonatomic, retain)UIScrollView *photoScroll;
@property(nonatomic, retain)Photots *photo;
@property(nonatomic, retain)NSMutableArray *getModels;
@property(nonatomic, retain)NewsModel *newsModel;



@end

@implementation Headerdetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 取出关键字
    NSString *one  = self.ID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    // 发请求
    [self sendRequestWithUrl:url];
    [self creatScrollview];
    
   }
/** 设置页面文字 */
- (void)setLabelWithModel:(Photots *)photoSet
{
    self.headerLabel.text = photoSet.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
//    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoSet.photos.count];
//    self.textlabel.text = countNum;
}

/** 添加内容 */
- (void)setContentWithIndex:(int)index
{
    NSString *content = [self.photo.photos[index] note];
    NSString *contentTitle = [self.photo.photos[index] imgtitle];
    if (content.length != 0) {
        self.textlabel.text = content;
    }else{
        self.textlabel.text = contentTitle;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScroll.contentOffset.x / self.photoScroll.frame.size.width;
    
    // 添加图片
    [self setImgWithIndex:index];
    
//    // 添加文字
//    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.photo.photos.count];
//    self.countLabel.text = countNum;
//    
    // 添加内容
    [self setContentWithIndex:index];
}

- (void)sendRequestWithUrl:(NSString *)url
{
    [[NetWorkTools sharNetworkTools]GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        Photots *photoSet = [Photots photoSetWith:responseObject];

        self.photo = photoSet;
        
        [self setLabelWithModel:photoSet];
        
        [self setImageViewWithModel:photoSet];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
/** 设置页面imgView */
- (void)setImageViewWithModel:(Photots *)photoSet
{
    NSUInteger count = self.photo.photos.count;
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        
        CGFloat x = i * photoImgView.frame.size.width * i;
        CGFloat y = 0;
        CGFloat h = self.view.frame.size.height - 200;
        CGFloat w = self.view.frame.size.width;
        photoImgView.frame = CGRectMake(x, y, w, h);
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode= UIViewContentModeCenter;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        [self.photoScroll addSubview:photoImgView];
        
    }
    
    
    [self setImgWithIndex:0];
    
    self.photoScroll.contentOffset = CGPointZero;
    self.photoScroll.contentSize = CGSizeMake(self.photoScroll.frame.size.width * count, 0);
    self.photoScroll.showsHorizontalScrollIndicator = NO;
    self.photoScroll.showsVerticalScrollIndicator = NO;
    self.photoScroll.pagingEnabled = YES;
}

- (void)setImgWithIndex:(int)i
{

    self.img = nil;
    if (i == 0) {
        self.img = self.photoScroll.subviews[i+2];
    }else{
        self.img = self.photoScroll.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:[self.photo.photos[i] imgsrc]];
    
    // 如果这个相框里还没有照片才添加
    if (self.img.image == nil) {
        [self.img sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:nil]];
    }
    
}




- (void)creatScrollview{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor clearColor];
    CGRect rectb = CGRectMake(10, 10, 30, 30);
    [self.button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    self.button.frame = rectb;
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    self.photoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, view.frame.size.height + 20 + 80, 375, self.view.frame.size.height - 20 - 120)];
    self.photoScroll.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.photoScroll];
 
    
}

 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }


@end
