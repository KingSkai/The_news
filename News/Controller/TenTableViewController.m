//
//  TenTableViewController.m
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TenTableViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "DataHandel.h"
#import "NetWorkTools.h"
#import "SecMyCell.h"
#import "ThirdMyCell.h"
#import "BigImageCell.h"
#import "BigImageCollectionViewcell.h"
#import "BigImageCellB.h"
#import "Photodetails.h"
#import "Celldetails.h"
#import "SubTableViewCell.h"



@interface TenTableViewController()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, retain)UICollectionView *collectview;
@property(nonatomic, retain)NSMutableArray *temparr;
@property(nonatomic,assign)BOOL update;
@property(nonatomic, retain)BigImageCell *cell1;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic, retain)UIPageControl *pagecontroler;
@property(nonatomic, assign)BOOL ret;
@end

@implementation TenTableViewController
static NSInteger count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    [self.tableView registerClass:[SecMyCell class] forCellReuseIdentifier:@"SecMyCell"];
    [self.tableView registerClass:[ThirdMyCell class] forCellReuseIdentifier:@"ThirdMyCell"];
    [self.tableView registerClass:[BigImageCell class] forCellReuseIdentifier:@"BigImageCell"];
    [self.tableView registerClass:[BigImageCellB class] forCellReuseIdentifier:@"BigImageCellB"];
    [self.tableView registerClass:[SubTableViewCell class] forCellReuseIdentifier:@"SubTableViewCell"];
    self.tableView.separatorStyle = NO;
    [self.tableView headerBeginRefreshing];


}

- (void)viewWillAppear:(BOOL)animated{

    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)headerRefresh{
    NSString *Astring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html", self.urlString];
    [self loadDataForType:1 withURL:Astring];
    
    
}
- (void)footerRefresh{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    [self loadDataForType:2 withURL:allUrlstring];
    
}

- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
    
    
    [[[NetWorkTools sharNetworkTools]GET:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
        
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        NSMutableArray *arrayM = [[NSMutableArray alloc]init];
        //快速枚举
        [temArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NewsModel *news = [NewsModel newsModelwithDic:obj];
            [arrayM addObject:news];
            
        }];
        if (type == 1) {
            
            self.arrayList = arrayM;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            self.tableView.separatorStyle = YES;
            self.arr = [NSMutableArray array];
            for (int i = 0; i < self.arrayList.count; i++) {
                if ([self.arrayList[i] hasHead ]) {
                    NSMutableArray *temarr = [[self.arrayList[i] imgextra]mutableCopy];
                    for (NSDictionary *dic in temarr) {
                        [self.arr addObject:dic];
                    }
                }
            }
        }
        if (type == 2) {
            [self.arrayList addObjectsFromArray:arrayM];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }] resume];
    
}



- (void)autoscroll:(NSTimer *)time {
    count++;
    NSInteger pagenbr = count % _arr.count;
    self.pagecontroler.currentPage = pagenbr;
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:pagenbr inSection:0];
    [self.cell1.collectview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
//collectionview的代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BigImageCollectionViewcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageCollectionViewcell" forIndexPath:indexPath];
    NewsModel *newmodel = self.arrayList[indexPath.row];
    cell.nm = newmodel;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Photodetails *dh = [[Photodetails alloc]init];
    dh.ID = [self.arrayList[indexPath.item] photosetID];
    [self presentViewController:dh animated:NO completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newmodel = self.arrayList[indexPath.row];
    if (newmodel.hasHead && newmodel.photosetID) {
        return 210;
    }
    else if(newmodel.hasHead){
        return 230;
    }else if(newmodel.imgType){
        return 130;
    }
    else if (newmodel.imgextra) {
        return 140;
    }else
        return 100;
}

// 内容判断并 赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *nm = self.arrayList[indexPath.row];
    // 主页大图 轮播图
    if (nm.hasHead && nm.photosetID) {
        self.cell1 = [tableView dequeueReusableCellWithIdentifier:@"BigImageCell" forIndexPath:indexPath];
        
        self.cell1.collectview.delegate = self;
        self.cell1.collectview.dataSource = self;
        self.pagecontroler.hidden = NO;
        self.pagecontroler.numberOfPages = self.arr.count;
         return self.cell1;
        
        
    }
    // 主页大图 没有轮播图
    else if(nm.hasHead){
        BigImageCellB *cell4 = [tableView dequeueReusableCellWithIdentifier:@"BigImageCellB" forIndexPath:indexPath];
        cell4.nm = nm;
        self.pagecontroler.hidden = YES;
        return cell4;
        
    }else if(nm.imgType){
        SubTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"SubTableViewCell"];
        cell5.nm = nm;
        self.pagecontroler.hidden = YES;
        return cell5;
    }
    else if (nm.imgextra ) {
        ThirdMyCell *cell3= [tableView dequeueReusableCellWithIdentifier:@"ThirdMyCell" forIndexPath:indexPath];
        cell3.nm = nm;
        return cell3;
    }
    else{
        SecMyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"SecMyCell" forIndexPath:indexPath];
        cell2.newsmodel = nm;
        NSString *timeStr = [nm.ptime substringWithRange:NSMakeRange(5, 11)];
        cell2.source.text = nm.source;
        cell2.postTime.text = timeStr;
        return cell2;
    }
    return nil;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger xx = self.cell1.collectview.contentOffset.x / self.view.frame.size.width;
    self.pagecontroler.currentPage = xx;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsModel *nm = self.arrayList[indexPath.row];
    if (nm.hasHead && nm.photosetID) {
        
        Photodetails *pt = [[Photodetails alloc]init];
        pt.ID = [self.arrayList[indexPath.row] photosetID];
        [self presentViewController:pt animated:YES completion:^{
            
        }];
        
        
    }
    else if(nm.hasHead){
        
        Celldetails *cell = [[Celldetails alloc]init];
        cell.cellString = nm.url_3w;
        cell.docidd = nm.docid;
        [self.navigationController pushViewController:cell animated:YES];
        
    } else if (nm.imgType){
        Celldetails *cell = [[Celldetails alloc]init];
        cell.cellString = nm.url_3w;
        cell.docidd = nm.docid;
        [self.navigationController pushViewController:cell animated:YES];
        
        
    }
    else if (nm.imgextra && nm.photosetID ) {
        Photodetails *pt = [[Photodetails alloc]init];
        pt.ID = [self.arrayList[indexPath.row] photosetID];
        self.tabBarController.tabBar.hidden = YES;
        [self presentViewController:pt animated:YES completion:^{
            
        }];
        
    }else{
        Celldetails *cell = [[Celldetails alloc]init];
        cell.cellString = nm.url_3w;
        cell.docidd = nm.docid;
        [self.navigationController pushViewController:cell animated:YES];
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count;
}




@end
