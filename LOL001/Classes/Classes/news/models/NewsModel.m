//
//  newsModel.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString: @"id"]) {
        self.myId = value;
    }
    if ([key isEqualToString: @"short"]) {
        self.shortDesc = value;
    }
    
}

// 未定义的key 值为空
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
