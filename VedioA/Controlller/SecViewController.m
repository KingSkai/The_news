//
//  SecViewController.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "SecViewController.h"
#import "GetDatas.h"
#import "SecItem.h"
#import "SecItemCell.h"
#import "ThirdViewController.h"
@interface SecViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, retain)UITableView *secTableview;

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(Action)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(30, 0, 30, 60)];
    
    
}
- (void)Action{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

// 获取数据
- (void)getData{
//   NSString *url = @"http://api2.qingting.fm/v5/media/categories/545/channels/order/recommend/curpage/1/pagesize/30";
    NSString *url = [NSString stringWithFormat:@"http://api2.qingting.fm/v5/media/categories/%@/channels/order/recommend/curpage/1/pagesize/30", self.urlStr];
    [GetDatas getDataWith:url completion:^(id result) {
        NSDictionary *dic = result;
        NSArray *arr = [dic objectForKey:@"data"];
        self.secItemArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in arr) {
            SecItem *s = [[SecItem alloc]init];
            [s setValuesForKeysWithDictionary:dic];
            [self.secItemArr addObject:s];
            NSLog(@"%@",[dic objectForKey:@"name"]);
            
        }
        
        
        
        
        [self createTableview];

    }];
}
// 创建tableview
- (void)createTableview{
    self.navigationController.navigationBar.translucent = NO;
    self.secTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    self.secTableview.backgroundColor = [UIColor whiteColor];
    self.secTableview.delegate = self;
    self.secTableview.dataSource = self;
    [self.secTableview registerClass:[SecItemCell class] forCellReuseIdentifier:@"SecItemCell"];
    [self.view addSubview:self.secTableview];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecItemCell" forIndexPath:indexPath];
    SecItem *s = self.secItemArr[indexPath.row];
    cell.s = s;
    cell.backgroundColor = [UIColor whiteColor];

    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.secItemArr.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdViewController *TVC = [[ThirdViewController alloc]init];
    SecItem *s = self.secItemArr[indexPath.row];
    TVC.urlstr = s.id;
    [self.navigationController pushViewController:TVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
