//
//  ReadViewController.m
//  ExploreWorld
//
//  Created by dlios on 15/7/13.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadCell.h"
#import "AFNetworking_Read.h"
#import "ReadDetailsController.h"
#import "ReadModel.h"
#import "MJRefresh.h"
#import "Header.h"

@interface ReadViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *handleArr;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    UIView *view = [[UIView alloc]init];
    view.center = CGPointMake([UIScreen mainScreen].bounds.origin.x, 30);
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(40, 40, 100, 40);
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:view.bounds];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.text = @"阅读";
    lable1.textColor = [UIColor whiteColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    [lable1 setFont:[UIFont boldSystemFontOfSize:20]];
    [view addSubview:lable1];
    self.navigationItem.titleView =view;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView addHeaderWithTarget:self action:@selector(getData)];
    [self.tableView addFooterWithTarget:self action:@selector(getMore)];
    [self.tableView headerBeginRefreshing];

}


- (void)getData
{
    NSString *str = @"http://rong.36kr.com/api/v1/news?category=column&is_feature=false&page=1&request_type=0";
    [AFNetworking_Read GETWithAFNByURL:str completion:^(id result) {
        self.handleArr = [ReadModel arraryWithModelByArray:[[result objectForKey:@"data"] objectForKey:@"feeds"]];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    }];
}



- (void)loadView
{
    [super loadView];

    //自定义定位按钮
    LocButton *Now = [[LocButton alloc] initWithFrame:CGRectMake(WIDTH - 60, 0, 50, 20)];
    [Now addTarget:self action:@selector(NowClick:) forControlEvents:UIControlEventTouchUpInside];
    [Now.loc setText:[LOC readLoc]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:Now]];
 }

- (void)NowClick:(id)sender
{
    WeatherViewController *weather = [[WeatherViewController alloc]init];
    [self presentViewController:weather animated:YES completion:nil];
}

- (void)getMore
{
    
    static NSInteger count = 1;
    NSString *temp = [[self.handleArr lastObject] feed_id];
    NSString *str = [NSString stringWithFormat:@"http://rong.36kr.com/api/v1/news?category=column&last_id=%@&page=%ld&request_type=1", temp, count++];
    [AFNetworking_Read GETWithAFNByURL:str completion:^(id result) {
        NSArray *tempArr = [ReadModel arraryWithModelByArray:[[result objectForKey:@"data"] objectForKey:@"feeds"]];
        [self.handleArr addObjectsFromArray:tempArr];
        [self.tableView headerEndRefreshing];
        
        [self.tableView reloadData];
    }];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}


- (void)creatTableView
{
    self.navigationController.navigationBar.translucent = NO;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
// 2个协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.handleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[ReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.handleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadDetailsController *detail = [[ReadDetailsController alloc] init];
    ReadModel *model = self.handleArr[indexPath.row];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
