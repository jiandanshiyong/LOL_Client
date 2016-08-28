//
//  HeroCell.m
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "HeroCell.h"
#import "UIImageView+AFNetworking.h"

@implementation HeroCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(HeroModel *)model{
    _model = model;
    
    [self.iconimageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:Default_Image];
    self.nameLabel.text = model.name_c;
    self.titleLabel.text = model.title;
    self.tagsLabel.text = model.tags;
    
    self.backgroundColor = [UIColor magentaColor];
}


@end
