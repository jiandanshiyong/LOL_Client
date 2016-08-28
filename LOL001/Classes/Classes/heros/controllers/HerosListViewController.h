//
//  HerosListViewController.h
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//

/**
 * 英雄列表页面
 */

#import "BaseViewController.h"
#import "EnumConstans.h"

@interface HerosListViewController : BaseViewController

// 列表页面区分tag
@property(nonatomic, assign) HeroType type;


@end
