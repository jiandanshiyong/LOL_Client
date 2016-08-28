//
//  AdCell.m
//  LOL001
//
//  Created by 张凯 on 16/7/7.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "AdCell.h"
#import "SDCycleScrollView.h"
#import "CONSTS.h"
#import "RecommModel.h"


@interface AdCell ()<SDCycleScrollViewDelegate>{
    SDCycleScrollView *_sdscrollView;
}

@end

@implementation AdCell

//纯代码的cell布局 初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSDscrollView];
    }
    return self;
}

//三方库创建AD
- (void)createSDscrollView{
    _sdscrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SWIDTH, 160) imageURLStringsGroup:nil];
    _sdscrollView.delegate =self;
    
    _sdscrollView.showPageControl = YES;
    _sdscrollView.autoScrollTimeInterval = 5.0f;
    _sdscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [self.contentView addSubview:_sdscrollView];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    RecommModel *model = _adSourceArr[index];
    
    if (_delegate &&  [_delegate respondsToSelector:@selector(didSelectAdCellWithId:)]) {
        [_delegate didSelectAdCellWithId:model.article_id];
    }
}


-(void)setAdSourceArr:(NSMutableArray *)adSourceArr{
    _adSourceArr = adSourceArr;
    
    NSMutableArray *imageURLArr = [[NSMutableArray alloc] init];
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    for (RecommModel *model in _adSourceArr) {
        NSString *imageURL = [model.ban_img URLDecodedString];//图片链接需要编码
        NSString *title = model.name;
        
        [imageURLArr addObject:imageURL];
        [titleArr addObject:title];
    }
    
    _sdscrollView.imageURLStringsGroup =imageURLArr;
    _sdscrollView.titlesGroup = titleArr;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
