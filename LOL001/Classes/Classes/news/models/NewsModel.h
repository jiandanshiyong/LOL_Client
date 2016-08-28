//
//  newsModel.h
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

/*
 {
 "id": "294992",
 "title": "\u3010LPL\u3011\u53cc\u65b9\u90fd\u6709\u5931\u8bef HYG\u540e\u671f\u7a81\u7136\u89c9\u9192\u518d\u80dc\u4e00\u5c40",
 "comment_count": 0,
 "source": "",
 "icon": "http:\/\/userimg.shiwan.com\/uploads\/manage\/66\/6f\/4994ae5aae3d41027dd61e21bd640be4d737.jpg",
 "short": "\u4e0b\u9762\u662fLPL\u5b63\u540e\u8d5bHYGvsM3\u6bd4\u8d5b\u60c5\u51b5M3BP\u76f4\u63a5ba..."
 }
 */


#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic, copy) NSString *myId; //关键字
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *comment_count;
@property(nonatomic, copy) NSString *source;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *shortDesc; //关键字

@end
