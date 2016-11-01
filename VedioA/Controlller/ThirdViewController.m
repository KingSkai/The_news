//
//  ThirdViewController.m
//  音频播放
//
//  Created by 王&甄 on 15/7/20.
//  Copyright (c) 2015年 王&甄. All rights reserved.
//

#import "ThirdViewController.h"
#import "GetDatas.h"
#import "ThirdViewController.h"
#import "ThirdItem.h"
#import "ThirdItemCell.h"
#import "SubThirdItem.h"
#import "AVplayerViewController.h"

@interface ThirdViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *urlArr;
@end

@implementation ThirdViewController

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

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)getData{
   
    NSString *url = [NSString stringWithFormat:@"http://api2.qingting.fm/v5/media/channels/%@/programs/curpage/1/pagesize/30", self.urlstr];
    [GetDatas getDataWith:url completion:^(id result) {
        NSDictionary *dic = result;
        NSArray *arr = [dic objectForKey:@"data"];
        self.thirdItemArr = [NSMutableArray array];
        self.urlArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in arr) {
            ThirdItem *t = [[ThirdItem alloc]init];
            [t setValuesForKeysWithDictionary:dic];
            [self.thirdItemArr addObject:t];
            self.SubthirdItemArr = [NSMutableArray array];
            NSDictionary *dicc = [dic objectForKey:@"mediainfo"];
            [self.urlArr addObject:dicc];
        }
        
        [self createTableview];
    }];
}
- (void)createTableview{
    self.navigationController.navigationBar.translucent = NO;
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 69 - 49)];
    
    table.backgroundColor = [UIColor grayColor];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[ThirdItemCell class] forCellReuseIdentifier:@"ThirdItemCell"];
    [self.view addSubview:table];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdItemCell"];
    ThirdItem *t = self.thirdItemArr[indexPath.row];
    cell.t = t;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVplayerViewController *avc = [AVplayerViewController shareInstance];

    avc.temarr = self.urlArr;
    avc.rownbr = indexPath.row;
    [avc getAvplayer:[self.urlArr[indexPath.row] objectForKey:@"download"]];
    [self.navigationController pushViewController:avc animated:NO];
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.thirdItemArr.count;
    
}
- (void)goback{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
