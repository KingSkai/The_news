//
//  Photodetails.m
//  The_news
//
//  Created by 王&甄 on 15/7/24.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "Photodetails.h"
#import "PhotoCollectionViewCell.h"
#import "NetWorkTools.h"
#import "Photots.h"
#import "DataHandel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PhotoSetModel.h"

@interface Photodetails ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, retain)UICollectionView *collectview;
@property(nonatomic, retain)Photots *photoSet;
@property(nonatomic, retain)NSMutableArray *dicarr;
@property(nonatomic, retain)NSDictionary *dic;
@property(nonatomic,retain)UIButton *button;

@end

@implementation Photodetails

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self getData];
    
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    lable.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lable];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"博 闻";
    [lable setTextColor:[UIColor whiteColor]];
    [lable setFont:[UIFont boldSystemFontOfSize:22]];
    [lable release];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor blackColor];
    CGRect rectb = CGRectMake(10, 15, 30, 30);
    [self.button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    self.button.frame = rectb;
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)getData{
    // 取出关键字
    NSString *one  = self.ID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    
    [DataHandel GetDataWithURLstr:url complete:^(id result) {
        self.dic = result;
        NSArray *arr = [self.dic objectForKey:@"photos"];
        
        self.dicarr = [[NSMutableArray alloc]init];
        for (NSDictionary *temdic in arr) {
            PhotoSetModel *ps = [[PhotoSetModel alloc]init];
            [ps setValuesForKeysWithDictionary:temdic];
            [self.dicarr addObject:ps];
        }
        [self createColloctionview];
    }];
    
    
}

- (void)goback{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
- (void)createColloctionview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - 100);
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
    self.collectview.pagingEnabled = YES;
    self.collectview.showsHorizontalScrollIndicator = NO;
    self.collectview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectview.backgroundColor = [UIColor blackColor];
    [self.collectview registerClass:[PhotoCollectionViewCell class]
         forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:self.collectview];
    self.collectview.delegate = self;
    self.collectview.dataSource = self;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    
    cell.headerLabel.text = [self.dic objectForKey:@"setname"];
    PhotoSetModel *temps = self.dicarr[indexPath.item];
    cell.ps = temps;
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dicarr.count ;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
