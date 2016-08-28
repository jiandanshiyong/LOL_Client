//
//  TweetCell.m
//  LOL001
//
//  Created by 张凯 on 16/7/9.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell (){
    UIImageView     *_iconImageView;  //用户头像视图
    UILabel         *_autherLabel;    //昵称

    UILabel         *_bodyLabel;     //微博内容
    UIImageView     *_smallImageView; //微博图片
    
    UILabel         *_timeLabel;  //发布时间
}

@end

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    
    }
    return self;
}

//初始化子视图 仅添加控件
- (void)_initView{
    //用户头像
    _iconImageView =[[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.backgroundColor =[UIColor clearColor];
    _iconImageView.layer.cornerRadius =5; //圆角半径
    _iconImageView.layer.borderWidth =.5;//边框宽度
    _iconImageView.layer.borderColor =[UIColor grayColor].CGColor;//边框颜色
    _iconImageView.layer.masksToBounds =YES; //剪切图层边界
    [self.contentView addSubview:_iconImageView];
    
    //昵称
    _autherLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _autherLabel.backgroundColor =[UIColor clearColor];
    _autherLabel.font =[UIFont boldSystemFontOfSize:16.0f];
    [self.contentView addSubview:_autherLabel];
    
    
    //正文内容
    _bodyLabel =[[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font =[UIFont systemFontOfSize:14.0f];
    _bodyLabel.numberOfLines = 0;
    [self addSubview:_bodyLabel];
    
    //微博图片
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _smallImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_smallImageView];
    
    
    //发布时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.font = [UIFont systemFontOfSize:14.0f];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_timeLabel];
}

-(void)setTfmodel:(TweetFrameModel *)tfmodel{
    _tfmodel = tfmodel;
    
    //model
    [_iconImageView setImageWithURL:[NSURL URLWithString:tfmodel.model.portrait] placeholderImage:Default_Image];
    _autherLabel.text = tfmodel.model.author;
    _bodyLabel.text = tfmodel.model.body;
    [_smallImageView setImageWithURL:[NSURL URLWithString:tfmodel.model.imgSmall] placeholderImage:Default_Image];
    _timeLabel.text = tfmodel.model.pubDate;
    
    //frame
    _iconImageView.frame = tfmodel.iconFrame;
    _autherLabel.frame = tfmodel.autherFrame;
    _bodyLabel.frame = tfmodel.bodyFrame;
    _smallImageView.frame = tfmodel.imgSmallFrame;
    _timeLabel.frame = tfmodel.timeFrame;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
