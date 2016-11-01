//
//  ViewController.m
//  音频播放
//
//  Created by 王&甄 on 15/7/19.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FistItemCell.h"
#import "AFNetworking.h"
#import "FirstItem.h"
#import "SecViewController.h"
#import "FistCollectionViewCell.h"
@interface ViewController ()< UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, retain)UITableView *tableview;
@property(nonatomic, retain)UIImageView *backgroundImageview;
@property(nonatomic, retain)UICollectionView *collectionview;
@property(nonatomic, retain)NSMutableArray *Picarr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]init];
    view.center = CGPointMake([UIScreen mainScreen].bounds.origin.x, 30);
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 40, 100, 40);

    UILabel *lable1 = [[UILabel alloc]initWithFrame:view.bounds];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"电台";
    lable1.textColor = [UIColor whiteColor];
    //   [lable1 sizeToFit];
    lable1.textAlignment = NSTextAlignmentCenter;
    [lable1 setFont:[UIFont boldSystemFontOfSize:18]];
    self.navigationItem.titleView = lable1;

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(Action)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(30, 0, 30, 60)];
    
    self.backgroundImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flower.jpeg"]];
    [self.view addSubview:self.backgroundImageview];
    [self getValue];
    
    self.Picarr = [NSMutableArray array];
    [self.Picarr addObject:@"news.jpg"];
    [self.Picarr addObject:@"music.jpg"];
    [self.Picarr addObject:@"book.jpg"];
    [self.Picarr addObject:@"xiaopin.jpg"];
    [self.Picarr addObject:@"enjoy.jpg"];
    [self.Picarr addObject:@"talkshow.jpg"];
    [self.Picarr addObject:@"fun.jpg"];
    [self.Picarr addObject:@"emotion.jpg"];
    [self.Picarr addObject:@"history.jpg"];
    [self.Picarr addObject:@"weapon.jpg"];
    [self.Picarr addObject:@"child.jpg"];
    [self.Picarr addObject:@"beauty.jpg"];
    [self.Picarr addObject:@"money.jpg"];
    [self.Picarr addObject:@"women.jpg"];
    [self.Picarr addObject:@"health.jpg"];
    [self.Picarr addObject:@"singchina.jpg"];
    [self.Picarr addObject:@"english.jpg"];
    [self.Picarr addObject:@"introduce.jpg"];
    [self.Picarr addObject:@"compus.jpg"];
    [self.Picarr addObject:@"openclass.jpg"];
    [self.Picarr addObject:@"tech.jpg"];
    [self.Picarr addObject:@"sport.jpg"];
    [self.Picarr addObject:@"car.jpg"];
    [self.Picarr addObject:@"dongman.jpg"];
    [self.Picarr addObject:@"youxi.jpg"];
    [self.Picarr addObject:@"onething.jpg"];

}
- (void)Action{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)getValue{
    NSString *urlstr = @"http://api2.qingting.fm/v5/media/categories/507";
    NSString *str = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manger  =[AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary *temDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *dataArr = [temDic objectForKey:@"data"];
            self.fstItemArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                FirstItem *f = [[FirstItem alloc]init];
                [f setValuesForKeysWithDictionary:dic];
                [self.fstItemArr addObject:f];
                
            }
            [self createCollectionView];
  
        }else{
            NSLog(@"no data");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
    
    
}

// 创建 collectionview
- (void)createCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(120, 180);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) collectionViewLayout:layout];
    self.collectionview.showsVerticalScrollIndicator = NO;
    
    self.collectionview.contentInset = UIEdgeInsetsMake(10, 25, 10, 25);
    [self.view addSubview:self.collectionview];
    self.collectionview.backgroundColor = [UIColor clearColor];
    [self.collectionview release];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[FistCollectionViewCell class] forCellWithReuseIdentifier:@"FistCollectionViewCell"];
}
// collevtionview代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstItem *f = self.fstItemArr[indexPath.row];
    SecViewController *SVC = [[SecViewController alloc]init];
    SVC.urlStr = f.id;
    [self.navigationController pushViewController:SVC animated:YES];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FistCollectionViewCell" forIndexPath:indexPath];
    cell.title.text = [self.fstItemArr[indexPath.row] name];
    [cell.img setImage:[UIImage imageNamed:self.Picarr[indexPath.row]]];
    return cell;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.fstItemArr.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
