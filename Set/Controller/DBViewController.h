//
//  DBViewController.h
//  The_news
//
//  Created by dlios on 15/7/19.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"
#import "CollectModel.h"
#import "DBPlayViewController.h"
@interface DBViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)UITableView *table;

//定义一个字符串属性，用来区分是从历史表还是收藏表查询
@property(nonatomic,retain)NSString *str;


@end
