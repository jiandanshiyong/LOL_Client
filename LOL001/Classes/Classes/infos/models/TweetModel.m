//
//  TweetModel.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel

//重写init  将数据传入处理
- (instancetype)initTweetByGDataXMLElement:(GDataXMLElement *)ele{
    if (self =[super init]) {
        for (GDataXMLElement *element in ele.children) {
            //KVC
            [self setValue:element.stringValue forKey:element.name];
        }
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"tweetID"]) {
        self.tweetID = value;
    }

}

@end
