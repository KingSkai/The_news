//
//  TenTableViewController.h
//  天下事
//
//  Created by dlios on 15-7-11.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenTableViewController : UITableViewController


//用来索引viewcontroller
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, retain)NSString *urlString;
@property(nonatomic, retain)NSMutableArray *arrayList;
@property(nonatomic, retain)NSMutableArray *arr;


@end
