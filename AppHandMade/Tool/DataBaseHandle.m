//
//  DataBaseHandle.m
//  AppHandMade
//
//  Created by Kris on 15/11/23.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "CollectModel.h"

@implementation DataBaseHandle
// 定义实例变量
static sqlite3 *db;
#pragma mark - 单例方法的实现

+ (instancetype) sharedDataBase {
    static DataBaseHandle *dataTool = nil;
    if (dataTool == nil) {
        dataTool = [[DataBaseHandle alloc] init];
    }
    return dataTool;
}

#pragma mark - 打开数据库

- (void) openDB {
    if (db != nil) {
//        NSLog(@"数据库已经打开");
        return;
    }
    
    // 数据库文件路径
    
    NSString *dbFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"model.db"];
    
    int result = sqlite3_open(dbFile.UTF8String, &db);
    
    if (result == SQLITE_OK) {
//        NSLog(@"打开数据库成功");
    } else {
//        NSLog(@"打开数据库失败");
//        NSLog(@"%d", result);
    }
    
    NSLog(@"%@", NSHomeDirectory());
    
}

#pragma mark - 创建表格

- (void) createTable {
    NSString *createSQL = @"create table if not exists collect (keyid integer primary key autoincrement, userName text, userId text, faceImage text)";
    int result = sqlite3_exec(db, createSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"创建表格成功");
    } else {
//        NSLog(@"创建表格失败");
//        NSLog(@"%d", result);
    }
    
}

#pragma mark - 查询

- (NSMutableArray *) selectCollectWithName:(NSString *)userName {
    // 查询结果放在数组中
    NSMutableArray *arr = [NSMutableArray array];
    
    // sql
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM collect WHERE userName = '%@'", userName];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
//        NSLog(@"查询中...");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *userName = sqlite3_column_text(stmt, 1);
            const unsigned char *userId = sqlite3_column_text(stmt, 2);
            const unsigned char *faceImage = sqlite3_column_text(stmt, 3);
            
            CollectModel *model = [[CollectModel alloc] init];
            model.userName = [NSString stringWithUTF8String:(const char *)userName];
            model.userId = [NSString stringWithUTF8String:(const char *)userId];
            model.faceImage = [NSString stringWithUTF8String:(const char *)faceImage];
            [arr addObject:model];
        }
        sqlite3_finalize(stmt);
    } else {
//        NSLog(@"无法查询");
//        NSLog(@"%d", result);
        sqlite3_finalize(stmt);
    }
    
    return arr;
}

#pragma mark - 查询无参数
- (NSMutableArray *)selecteCollect {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *selectSQL = @"SELECT * FROM collect";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
//        NSLog(@"查询中......");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *userName = sqlite3_column_text(stmt, 1);
            const unsigned char *userId = sqlite3_column_text(stmt, 2);
            const unsigned char *faceImage = sqlite3_column_text(stmt, 3);
            CollectModel *model = [[CollectModel alloc] init];
            
            model.userName = [NSString stringWithUTF8String:(const char *)userName];
            model.userId = [NSString stringWithUTF8String:(const char *)userId];
            model.faceImage = [NSString stringWithUTF8String:(const char *)faceImage];
            
            [arr addObject:model];
        }
        
        sqlite3_finalize(stmt);
    } else {
//        NSLog(@"无法查询");
//        NSLog(@"%d", result);
        sqlite3_finalize(stmt);
    }
    return arr;
}

#pragma mark - 插入数据
- (void)insertCollect:(CollectModel *)model {
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into collect (userName , userId, faceImage) values('%@','%@','%@')", model.userName, model.userId, model.faceImage];
    int result = sqlite3_exec(db, insertSQL.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
    } else {
//        NSLog(@"插入数据失败");
//        NSLog(@"%d", result);
    }
}

#pragma mark - 删除数据
- (void)deleteCollectWithName:(NSString *)userName {
    NSString *deletSQL = [NSString stringWithFormat:@"DELETE FROM collect WHERE userName = '%@'",userName];
    
    int result = sqlite3_exec(db, deletSQL.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
//        NSLog(@"删除数据成功");
    } else {
//        NSLog(@"删除数据失败");
//        NSLog(@"%d", result);
    }
}

#pragma mark - 关闭数据库
- (void)closeDB {
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
//        NSLog(@"关闭数据库成功");
        db = nil;
    } else {
//        NSLog(@"关闭数据库失败");
//        NSLog(@"%d", result);
    }
}

@end
