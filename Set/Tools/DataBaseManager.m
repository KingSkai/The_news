//
//  DataBaseManager.m
//  The_news
//
//  Created by dlios on 15/7/18.
//  Copyright (c) 2015年 chenlin. All rights reserved.
//

#import "DataBaseManager.h"
#import "CollectModel.h"

@implementation DataBaseManager
+ (DataBaseManager *)shareInstance
{
    static DataBaseManager *dbManager = nil;
    if (dbManager == nil) {
        dbManager = [[DataBaseManager alloc] init];
    }
    return dbManager;
}
// 打开数据库
- (void)openDB
{
//    // 数据库一般存放在documents文件夹下
//    // 获取document文件路径
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    // 拼接数据库路径
//    NSString *dbPath = [path stringByAppendingPathComponent:@"MyNews.db"];
//    // 创建数据库
//    // 检测路径下 是否已经存在数据库 如果不存在 才创建(查看sqlite3指针是否指向了数据库)
//    // 参数1: 本地数据库的路径(需要UTF-8转码)
//    // 参数2: 数据库指针地址
//    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
//    NSLog(@"打开结果: %d, path: %@", result, dbPath);
    
    //判断Documents中是否有数据库文件, 如果没有则拷贝进去, 如果有则什么都不做
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    //path数据库的路径
    path = [NSString stringWithFormat:@"%@/MyNews.rdb", path];
      NSLog(@"%@",path);
    //设置BOOL类型判断是否存在存放数据库
    BOOL judge = [manager fileExistsAtPath:path];
    if (!judge) {
        //如果没有就把数主文件中的数据库拷贝到Library下
        NSString *source = [[NSBundle mainBundle] pathForResource:@"MyNews" ofType:@"rdb"];
        [manager copyItemAtPath:source toPath:path error:nil];
    } else {
        //        NSLog(@"已拷贝");
    }
    //获得拷贝到的数据库文件的指针
    
     int result =  sqlite3_open([path UTF8String], &dbPoint);
    NSLog(@"%d",result);
    
    
    
}

// 关闭数据库
- (void)closeDB
{
    sqlite3_close(dbPoint);
    
}






//// 插入对象信息

//插入到浏览历史表
- (void)insertInfoWithNewsHistory:(CollectModel *)history
{
    // 1.创建sql语句
    NSString *insertStr = [NSString stringWithFormat:@"insert into NewsHistory  values ('%@', '%@','%@','%@','%@')", history.ima,history.title,history.url,history.mediaUrl,history.feed_id];
    // 2.执行语句
    int result = sqlite3_exec(dbPoint, insertStr.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (SQLITE_OK == result) {
         NSLog(@"插入到历史表成功");
    } else {
        NSLog(@"%d",result);
        NSLog(@"插入到历史表失败");
    }
}

//插入到收藏表
- (void)insertInfoWithNewsCollect:(CollectModel *)collect
{
    // 1.创建sql语句
    NSString *insertStr = [NSString stringWithFormat:@"insert into  NewsCollect  values ('%@', '%@','%@','%@','%@')", collect.ima,collect.title,collect.url,collect.mediaUrl,collect.feed_id];
    NSLog(@"%@",insertStr);
    // 2.执行语句
    int result = sqlite3_exec(dbPoint, insertStr.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (SQLITE_OK == result) {
        NSLog(@"插入到收藏成功");
    } else {
        NSLog(@"%d",result);
        NSLog(@"插入到收藏失败");
    }
}


//
//// 更新对象信息
//- (void)updateInfoWithLanou03:(lanou03 *)lanou number:(NSInteger)num
//{
//    // 1.创建sql语句
//    NSString *updateSQL = [NSString stringWithFormat:@"update lanou03 set name = '%@', age = '%ld' where num = '%ld'", lanou.name, lanou.age, num];
//    // 2.执行语句
//    int result = sqlite3_exec(dbPoint, updateSQL.UTF8String, NULL, NULL, nil);
//    // 3.判断
//    if (SQLITE_OK == result) {
//        NSLog(@"更新成功");
//    } else {
//        NSLog(@"更新失败");
//    }
//}
//

//// 查询

//从浏览历史查询
- (NSMutableArray *)selectInfoFromNewsHistory
{
    // 查询操作逻辑
    // 1.从本地数据获取所有信息 遍历获取每条信息
    // 2.把每条信息转化为Model对象
    // 3.把Model添加在可变数组中返回
    
    // 1.创建sql语句
    // select * 查询所有
    NSString *selectSQL = @"select * from NewsHistory";
    // 2.创建数据库替身
    sqlite3_stmt *stmt = nil;
    // 3.准备sql语句
    // prepare_v2函数 把数据库对象/sql语句/数据库替身 关联在了一起
    int result = sqlite3_prepare_v2(dbPoint, selectSQL.UTF8String, -1, &stmt, nil);
    // 4.创建存放返回数据的信息数组
    NSMutableArray *arr = [NSMutableArray array];
    // 5.判断查询准备
    if (SQLITE_OK == result) {
        NSLog(@"查询准备成功");
        // 6.开始遍历每一行信息
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 当数据库提升指向的数据符合查询条件 在while中返回
            // 逐行 获取每一列的数据
            // 列数从0开始
            const unsigned char *ima = sqlite3_column_text(stmt, 0);
             const unsigned char *title = sqlite3_column_text(stmt, 1);
             const unsigned char *url = sqlite3_column_text(stmt, 2);
             const unsigned char *mediaUrl = sqlite3_column_text(stmt, 3);
            const unsigned char *feed_id = sqlite3_column_text(stmt, 4);
            // 访问到数据库数据 转化添加在Model中
            CollectModel *temp = [[CollectModel alloc] init];
            temp.ima = [NSString stringWithUTF8String:(const char *)ima];
            temp.title = [NSString stringWithUTF8String:(const char *)title];
            temp.url = [NSString stringWithUTF8String:(const char *)url];
            temp.mediaUrl = [NSString stringWithUTF8String:(const char *)mediaUrl];
            temp.feed_id = [NSString stringWithUTF8String:(const char *)feed_id];
            // 把Model对象添加在数组中
            [arr addObject:temp];
        }
    }
    else {
        NSLog(@"查询准备失败");
    }
    return arr;
}

//从收藏表查询
- (NSMutableArray *)selectInfoFromNewsCollect
{
    // 查询操作逻辑
    // 1.从本地数据获取所有信息 遍历获取每条信息
    // 2.把每条信息转化为Model对象
    // 3.把Model添加在可变数组中返回
    
    // 1.创建sql语句
    // select * 查询所有
    NSString *selectSQL = @"select * from  NewsCollect";
    // 2.创建数据库替身
    sqlite3_stmt *stmt = nil;
    // 3.准备sql语句
    // prepare_v2函数 把数据库对象/sql语句/数据库替身 关联在了一起
    int result = sqlite3_prepare_v2(dbPoint, selectSQL.UTF8String, -1, &stmt, nil);
    // 4.创建存放返回数据的信息数组
    NSMutableArray *arr = [NSMutableArray array];
    // 5.判断查询准备
    if (SQLITE_OK == result) {
        NSLog(@"查询准备成功");
        // 6.开始遍历每一行信息
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 当数据库提升指向的数据符合查询条件 在while中返回
            // 逐行 获取每一列的数据
            // 列数从0开始
            const unsigned char *ima = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *url = sqlite3_column_text(stmt, 2);
            const unsigned char *mediaUrl = sqlite3_column_text(stmt, 3);
            const unsigned char *feed_id = sqlite3_column_text(stmt, 4);

            // 访问到数据库数据 转化添加在Model中
            CollectModel *temp = [[CollectModel alloc] init];
            temp.ima = [NSString stringWithUTF8String:(const char *)ima];
            temp.title = [NSString stringWithUTF8String:(const char *)title];
            temp.url = [NSString stringWithUTF8String:(const char *)url];
            temp.mediaUrl = [NSString stringWithUTF8String:(const char *)mediaUrl];
           temp.feed_id = [NSString stringWithUTF8String:(const char *)feed_id];

            // 把Model对象添加在数组中
            [arr addObject:temp];
        }
    }
    else {
        NSLog(@"查询准备失败");
    }
    return arr;
}






//// 删除
//在浏览历史里删除
- (void)deleteInfoFromNewsHistoryWithTitle:(NSString *)title
{
    // 1.创建sql语句
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from NewsHistory where title = '%@'", title];
    // 2.执行语句
    int result = sqlite3_exec(dbPoint, deleteSQL.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

//在收藏表里删除
- (void)deleteInfoFromNewsCollectWithTitle:(NSString *)title
{
    // 1.创建sql语句
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from NewsCollect where title = '%@'", title];
    // 2.执行语句
    int result = sqlite3_exec(dbPoint, deleteSQL.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}






//// 删除表
//删除浏览历史表
- (void)dropNewsHistoryTable
{
    // 1.sql语句
    NSString *dropSQL = @"drop table HistoryTable";
    // 2.执行
    int result = sqlite3_exec(dbPoint, dropSQL.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (result == SQLITE_OK) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}

//删除收藏表
- (void)dropNewsCollectTable
{
    // 1.sql语句
    NSString *dropSQL = @"drop table NewsCollect";
    // 2.执行
    int result = sqlite3_exec(dbPoint, dropSQL.UTF8String, NULL, NULL, nil);
    // 3.判断
    if (result == SQLITE_OK) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}



@end
