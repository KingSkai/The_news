//
//  DataBaseManager.h
//  The_news
//
//  Created by dlios on 15/7/18.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CollectModel.h"
@interface DataBaseManager : NSObject
{
    sqlite3 *dbPoint;
}

// 想要在任何一个使用数据的地方 使用的是同一个数据库把数据库管理类 写成单例
+ (DataBaseManager *)shareInstance;
// 打开数据库
- (void)openDB;
// 关闭数据库
- (void)closeDB;





//插入到浏览历史表
- (void)insertInfoWithNewsHistory:(CollectModel *)history;
//插入到收藏表
- (void)insertInfoWithNewsCollect:(CollectModel *)collect;



//从浏览历史查询
- (NSMutableArray *)selectInfoFromNewsHistory;
//从收藏表查询
- (NSMutableArray *)selectInfoFromNewsCollect;




//在浏览历史里删除
- (void)deleteInfoFromNewsHistoryWithTitle:(NSString *)title;
//在收藏表里删除
- (void)deleteInfoFromNewsCollectWithTitle:(NSString *)title;


//删除浏览历史表
- (void)dropNewsHistoryTable;
//删除收藏表
- (void)dropNewsCollectTable;
@end
