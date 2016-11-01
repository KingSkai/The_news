//
//  DBViewController.m
//  The_news
//
//  Created by dlios on 15/7/19.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DBViewController.h"
#import "Header.h"
#import "DBTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DataBaseManager.h"
#import "DBPlayViewController.h"
#import "ReadDetailsController.h"
#import "Celldetails.h"
#import "KVNProgress.h"

@interface DBViewController ()

@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

- (void)loadView
{
    [super loadView];
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    if ([self.str isEqualToString:@"浏览历史"]) {
        self.navigationItem.title = @"我的历史";
        self.dataArray =  [dbManager   selectInfoFromNewsHistory];
        if (self.dataArray.count == 0) {
            [KVNProgress showErrorWithStatus:@"您未有浏览过新闻!"];
        }
        
    }
    else
    {
        self.navigationItem.title  = @"我的收藏";
        self.dataArray =  [dbManager   selectInfoFromNewsCollect];
        if (self.dataArray.count == 0) {
            [KVNProgress showErrorWithStatus:@"收藏记录为空!"];
        }
    }
    [self.table reloadData];

    [self createTableView];
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = self.str;

    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}




//创建tableView,将数据库相关表的数据全部拿出来呈现

- (void)createTableView
{ self.navigationController.navigationBar.translucent = NO;
 //   self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 69 - 49) style:UITableViewStylePlain];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 69 - 49)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DBCellIden = @"cell";
    
    DBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DBCellIden];
    if (!cell) {
        cell = [[DBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DBCellIden];
    }
    
    CollectModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    [cell.title setText:model.title];
    [cell.ima sd_setImageWithURL:[NSURL URLWithString:model.ima] placeholderImage:[UIImage imageNamed:@"placeHold.jpg"] options:SDWebImageRetryFailed];
    
//    NSString *s = model.mediaUrl;
  
    
    if (![model.mediaUrl isEqualToString:@"(null)"]) {
        [cell.type setImage:[UIImage imageNamed:@"media.png"]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CollectModel *model = [[CollectModel alloc]init];
    model = self.dataArray[indexPath.row];
    if (![model.mediaUrl isEqualToString:@"(null)"]) {
        //创建播放界面
        DBPlayViewController *play = [[DBPlayViewController alloc]init];
        play.playUrl = model.mediaUrl;
        NSLog(@"%@",play);
        [self.navigationController pushViewController:play animated:YES];
    }
    else if (![model.feed_id isEqualToString:@"(null)"])
    {
//        NSLog(@"model.feed_id:%@", model.feed_id);
        ReadDetailsController *read = [[ReadDetailsController alloc] init];
//        read.model.feed_id = model.feed_id;
        read.feed_id = model.feed_id;
        [self.navigationController pushViewController:read animated:YES];

    }else if(![model.url isEqualToString:@"(null)"]){
        //进入到新闻界面
        Celldetails *cd = [[Celldetails alloc]init];
        cd.docidd = model.url;
        [self.navigationController pushViewController:cd animated:YES];
        
    }
    
        
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectModel *model = self.dataArray[indexPath.row];
    DataBaseManager *dbManager = [DataBaseManager shareInstance];
    [dbManager openDB];
    if ([self.str isEqualToString:@"浏览历史"]) {
        self.navigationItem.title = @"我的历史";
        
      [dbManager   deleteInfoFromNewsHistoryWithTitle:model.title];
          self.dataArray =  [dbManager   selectInfoFromNewsHistory];
        
    }
    else
    {
         [dbManager   deleteInfoFromNewsCollectWithTitle:model.title];
        self.dataArray =  [dbManager   selectInfoFromNewsCollect];
    }
    [self.table reloadData];
}



@end
