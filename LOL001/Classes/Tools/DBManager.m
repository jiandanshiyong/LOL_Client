//
//  DBManager.m
//  2_FMDB使用
//
//  Created by RichyLeo on 16/7/2.
//  Copyright © 2016年 WTC. All rights reserved.
//

#import "DBManager.h"

static DBManager * manager = nil;

@implementation DBManager

// 单例创建对象的方式
+(DBManager *)sharedManager
{
    @synchronized(self) {
        if(manager == nil){
            manager = [[DBManager alloc] init];
        }
    }
    return manager;
}

-(instancetype)init
{
    if(self = [super init]){
        
        // 数据库db文件的路径
        NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"cache.db"];
        
        NSLog(@"数据库path = %@", path);
        
        // 创建唯一的数据库 database
        _database = [[FMDatabase alloc] initWithPath:path];
        
        
        // 操作数据库之前确保open，当使用完毕之后，为保证数据安全性应将其关闭
        if([_database open]){
            // 创建表
            NSString * sql = @"create table if not exists NewsModel (id varchar(10) primary key, title text, comment_count varchar(10), source text, icon text, short text )";
            BOOL isSuccess = [_database executeUpdate:sql];
            if(!isSuccess){
                NSLog(@"create table Error: %@", _database.lastErrorMessage);
            }
        }
    }
    return self;
}

// insert
-(void)insertDataModel:(NewsModel *)model
{
    if([_database open]){
        NSString * sql = @"insert into NewsModel (id, title, comment_count, source, icon, short) values (?, ?, ?, ?, ?, ?)";
        BOOL isSuccess = [_database executeUpdate:sql, model.myId, model.title,model.comment_count, model.source, model.icon, model.shortDesc];
        if(!isSuccess){
            NSLog(@"insert data Error: %@", _database.lastErrorMessage);
        }
    }
    // 关闭数据库
    [_database close];
}

// select
-(NSArray *)findAll
{
    NSMutableArray * resultArr = [NSMutableArray new];
    if([_database open]){
        NSString * sql = @"select * from NewsModel";
        FMResultSet * set = [_database executeQuery:sql];
        while ([set next]) {
            NewsModel * model = [[NewsModel alloc] init];
            model.myId = [set stringForColumn:@"id"];
            model.title = [set stringForColumn:@"title"];
            model.comment_count = [set stringForColumn:@"comment_count"];
            model.source = [set stringForColumn:@"source"];
            model.icon = [set stringForColumn:@"icon"];
            model.shortDesc = [set stringForColumn:@"short"];
            
            [resultArr addObject:model];
        }
    }
    [_database close];
    
    return resultArr;
}

/*
 * 是否有某条数据
 */
-(BOOL)isExistsFormModel:(NSString *)newsId{
    if([_database open]){
        NSString * sql = @"select * from NewsModel where id = ?";
        FMResultSet * set = [_database executeQuery:sql, newsId];
        
        while ([set next]) {
            [_database close];
            return YES;
        }
    }
    [_database close];
    return NO;
}

-(void)deleteDataModel:(NSString *)newsId{
    if([_database open]){
        NSString * sql = @"delete from NewsModel where id = ?";
        BOOL isSuccess = [_database executeUpdate:sql, newsId];
        
        if (!isSuccess) {
            NSLog(@"data delete Error: %@", _database.lastErrorMessage);
        }
    }
    
    [_database close];
}


@end
