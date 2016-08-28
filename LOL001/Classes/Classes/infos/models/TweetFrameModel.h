//
//  TweetFrameModel.h
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetModel.h"

/**
 *  根据信息， 计算cell上各UI控件的Frame  计算cell的总高度
 */
@interface TweetFrameModel : NSObject

@property(nonatomic, strong) TweetModel *model;

@property(nonatomic, assign) CGFloat totalHeight;

//各控件的frames
@property(nonatomic, assign) CGRect iconFrame;
@property(nonatomic, assign) CGRect autherFrame;
@property(nonatomic, assign) CGRect bodyFrame;
@property(nonatomic, assign) CGRect imgSmallFrame;
@property(nonatomic, assign) CGRect timeFrame;

@end
