//
//  NewsCell.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "CONSTS.h"
#import "DBManager.h"

@implementation NewsCell

- (IBAction)likeAction:(id)sender {
    UIButton *likeBtn = (UIButton *)sender;
    
    //判断条件： 数据库中是否存在该数据；
    if ([[DBManager sharedManager] isExistsFormModel:_model.myId]) {
        //有数据 删除数据 显示like
        [[DBManager sharedManager] deleteDataModel:_model.myId];
        
        [likeBtn setTitle:@"Like" forState:UIControlStateNormal];
    } else {
        // 没有数据  保存数据  显示cancel
        [[DBManager sharedManager] insertDataModel:_model];
        
        [likeBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    }
}


- (void)setModel:(NewsModel *)model{
    _model = model;
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:Default_Image];
    _titleLabel.text = model.title;
    _descLabel.text = model.shortDesc;
    
    //正确显示btn的状态， 解决cell复用导致的显示问题
    if ([[DBManager sharedManager] isExistsFormModel:_model.myId]) {
        [_likeButton setTitle:@"Cancel" forState:UIControlStateNormal];
    } else {
        [_likeButton setTitle:@"Like" forState:UIControlStateNormal];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
