//
//  TweetFrameModel.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "TweetFrameModel.h"

#define marginX 10 //水平方向上间距
#define marginY 6  //垂直方向上间距

@implementation TweetFrameModel

- (void)setModel:(TweetModel *)model{
    _model = model;
    
    //头像
    self.iconFrame = CGRectMake(marginX,marginY, 70, 70);
    
    //右侧视图的起点
    CGFloat iconRight = CGRectGetMaxX(self.iconFrame)+marginX;
    
    //昵称
    CGFloat width = SWIDTH -iconRight - marginX;
    self.autherFrame = CGRectMake(iconRight, marginY, width, 24);
    
    // bodyFrame;
    CGSize size = [model.body boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}
                                            context:nil].size;
    self.bodyFrame = CGRectMake(iconRight, CGRectGetMaxY(self.autherFrame)+marginY, width, size.height);
    
    // imgSmallFrame;
    if (model.imgSmall.length >0) {
        self.imgSmallFrame = CGRectMake(iconRight, CGRectGetMaxY(self.bodyFrame)+marginY, 120, 120);
    }else{
        self.imgSmallFrame = CGRectMake(iconRight, CGRectGetMaxY(self.bodyFrame), 120, 0);
    }
    
    // timeFrame;
    self.timeFrame = CGRectMake(iconRight, CGRectGetMaxY(self.imgSmallFrame)+marginY, width, 20);
    
    self.totalHeight = CGRectGetMaxY(self.timeFrame) + marginY;
}

@end
