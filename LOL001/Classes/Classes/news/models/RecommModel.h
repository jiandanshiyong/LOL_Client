//
//  RecommModel.h
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

/*
 {
 "article_id": "293793",
 "comment_count": 31,
 "ban_img": "http%3A%2F%2Fuserimg.shiwan.com%2Fuploads%2Fmanage%2F70%2Fec%2F52eda149a0b5ec69bc68689d30ed8e7e3bb3.jpg",
 "name": "\u3010\u5b98\u65b9\u3011\u672c\u5468\u534a\u4ef7\u82f1\u96c4\u53ca\u76ae\u80a4"
 }
 */

#import <Foundation/Foundation.h>

@interface RecommModel : NSObject

@property(nonatomic, copy) NSString *article_id;
@property(nonatomic, copy) NSString *comment_count;
@property(nonatomic, copy) NSString *ban_img;
@property(nonatomic, copy) NSString *name;

@end
