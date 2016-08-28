//
//  HeroCell.h
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"

@interface HeroCell : UICollectionViewCell


@property(nonatomic, retain) HeroModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *iconimageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *tagsLabel;


@end
