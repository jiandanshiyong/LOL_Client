//
//  TweetModel.h
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

/*
     <tweet>
     <id>9505808</id>
     <portrait>http://static.oschina.net/uploads/user/1281/2563158_50.jpg?t=1450933201000</portrait>
     <author><![CDATA[ OSC首席众包打湿 ]]></author>
     <authorid>2563158</authorid>
     <body><![CDATA[ 今天OSC怎么了，光头不在家吗？[微笑] ]]></body>
     
     <attach/>
     <appclient>1</appclient>
     <commentCount>0</commentCount>
     <pubDate>2016-06-30 16:50:00</pubDate>
     <imgSmall/>
     
     <imgBig/>
     <likeCount>0</likeCount>
     <isLike>0</isLike>
     <likeList></likeList>
     </tweet>
 */


#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface TweetModel : NSObject

@property(nonatomic, copy) NSString * tweetID; //基本数据类型
@property(nonatomic, copy) NSString * portrait; //头像
@property(nonatomic, copy) NSString * author; //昵称
@property(nonatomic, copy) NSString * authorid;
@property(nonatomic, copy) NSString * body;  //内容

@property(nonatomic, copy) NSString * attach;
@property(nonatomic, copy) NSString * appclient;
@property(nonatomic, copy) NSString * commentCount;
@property(nonatomic, copy) NSString * pubDate;  //发布时间
@property(nonatomic, copy) NSString * imgSmall; //小图模式

@property(nonatomic, copy) NSString * imgBig;   //大图模式
@property(nonatomic, copy) NSString * likeCount;
@property(nonatomic, copy) NSString * isLike;
@property(nonatomic, copy) NSString * likeList;


/**
 *  重写init  将数据传入处理
 */
- (instancetype)initTweetByGDataXMLElement:(GDataXMLElement *)ele;

@end
