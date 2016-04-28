//
//  WBStatusDataTool.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/26.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusDataTool.h"
#import "FMDB.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

@implementation WBStatusDataTool

static FMDatabase *_db;

/** 打开数据库，创表 */
+ (void)initialize
{
    // 打开数据库
    // 创建数据库路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statues.db"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
//    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL, token text NOT NULL);"];
}

+ (NSArray *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的SQL语句
    NSString *sql = nil;
    if (params[@"max_id"]) { // 加载更多
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"]];
//        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ AND token = %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"], params[@"access_token"]];
    } else if (params[@"since_id"]) { // 加载最新数据
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", params[@"since_id"]];
//        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ AND token = %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"], params[@"access_token"]];
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;"];
//        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE token = %@ ORDER BY idstr DESC LIMIT 20;", params[@"access_token"]];
    }
    
    // 执行SQL语句
    FMResultSet *set = [_db executeQuery:sql];
    // 存放微博
    NSMutableArray *statuses = [NSMutableArray array];
    while ([set next]) { // 如果有数据就不断取出下一条数据，没有就不会执行
        // 取出微博NSData
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

+ (void)saveStatuses:(NSArray *)statuses
{
    // 取出账户
//    WBAccount *currentAccount = [WBAccountTool account];
    
    // 新浪返回的每一条微博都是一个字典
    // 将每一条微博以NSData形式存进沙盒（遵守NSCoding）
    for (NSDictionary *status in statuses) {
        NSData *statusesData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status (status, idstr) VALUES (%@, %@);", statusesData, status[@"idstr"]];
//        [_db executeUpdateWithFormat:@"INSERT INTO t_status (status, idstr, token) VALUES (%@, %@, %@);", statusesData, status[@"idstr"], currentAccount.access_token];
    }
}
@end
