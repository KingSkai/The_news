//
//  MakeContect.m
//  The_news
//
//  Created by 王&甄 on 15/7/23.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "MakeContect.h"
#import "NewsViewController.h"
@interface MakeContect ()
@property(nonatomic, retain)UICollectionView *collectinviewA;

@property(nonatomic, retain)UILabel *bview;
@property(nonatomic, retain)UIView *Sview;
@property(nonatomic, retain)UIView *BBview;
@property(nonatomic, retain)NewsViewController *nvc;

@end

@implementation MakeContect

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UILabel *labell = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    labell.backgroundColor = [UIColor clearColor];
    labell.text = @"内容定制";
    [labell setTextColor:[UIColor whiteColor]];
    labell.textAlignment = NSTextAlignmentCenter;
    [labell setFont:[UIFont boldSystemFontOfSize:18]];
    self.navigationItem.titleView = labell;
    self.navigationController.navigationBar.translucent = NO;
    
    self.BBview = [[UIView alloc]init];
    self.BBview.frame = CGRectMake(10, 50, self.view.frame.size.width - 20, 200);
    self.BBview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.BBview];
    
    self.bview = [[UILabel alloc]init];
    self.bview.frame = CGRectMake(10,self.BBview.frame.origin.y - 30 , self.view.frame.size.width - 20, 30);
    self.bview.backgroundColor = [UIColor whiteColor];
    self.bview.alpha = 0.5;
    self.bview.text = @">> 已有栏目";
    [self.bview setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:self.bview];
    
    self.Sview = [[UIView alloc]init];
    self.Sview.frame = CGRectMake(10, self.BBview.frame.size.height + 40 + 60, self.view.frame.size.width - 20, 200);
    [self.view addSubview:self.Sview];
    self.Sview.backgroundColor = [UIColor whiteColor];
    
    UILabel *slabel = [[UILabel alloc]init];
    slabel.text = @">> 添加栏目";
    [slabel setFont:[UIFont boldSystemFontOfSize:15]];
    //  [slabel set ]
    slabel.backgroundColor = [UIColor whiteColor];
    slabel.alpha = 0.5;
    slabel.frame = CGRectMake(10,self.BBview.frame.size.height + 40 + 60 - 30 , self.view.frame.size.width - 20, 30);
    [self.view addSubview:slabel];
    [self creatbuttonA];
    [self createbuttonB];
    
    
    
}
- (void)creatbuttonA{
    
    int count = (int)self.hasNamesArr.count;
    
    int total = 4;
    CGFloat w = 60;
    CGFloat h = 30;
    CGFloat margin = (self.view.frame.size.width - total * w) / (total + 1) ;
    
    for (int i = 0; i < count; i++) {
        int row = i / total;
        int loc = i % total;
        CGFloat lx = (margin + w)*loc + 15;
        CGFloat ly = (margin + h) * row + 5;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(lx, ly, w, h)];
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:self.hasNamesArr[i] forState:UIControlStateNormal];
        [self.BBview addSubview:button];
    }
}

- (void)createbuttonB{
    int count = (int)self.restNamesArr.count;
    int total = 4;
    CGFloat w = 60;
    CGFloat h = 30;
    CGFloat margin = (self.view.frame.size.width - total * w) / (total + 1) ;
    
    for (int i = 0; i < count; i++) {
        int row = i / total;
        int loc = i % total;
        CGFloat lx = (margin + w)*loc + 15;
        CGFloat ly = (margin + h) * row + 5;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(lx, ly, w, h)];
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:self.restNamesArr[i] forState:UIControlStateNormal];
        [self.Sview addSubview:button];
        [button addTarget:self action:@selector(addName:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
- (void)addName:(UIButton *)button{
    self.nvc = [[NewsViewController alloc]init];
    [self.nvc makeContent];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
