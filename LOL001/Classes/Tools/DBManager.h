//
//  DBManager.h
//  2_FMDB使用
//
//  Created by RichyLeo on 16/7/2.
//  Copyright © 2016年 WTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "NewsModel.h"

@interface DBManager : NSObject

// 数据库
@property (nonatomic, strong) FMDatabase * database;

+(DBManager *)sharedManager;

// insert
-(void)insertDataModel:(NewsModel *)model;

// delete
-(void)deleteDataModel:(NSString *)newsId;

// select
-(NSArray *)findAll;

//select by id
-(BOOL)isExistsFormModel:(NSString *)newsId;

@end
