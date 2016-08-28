//
//  AdCell.h
//  LOL001
//
//  Created by 张凯 on 16/7/7.
//  Copyright © 2014年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADCellDelegate <NSObject>

- (void)didSelectAdCellWithId:(NSString *)newsId;

@end

@interface AdCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *adSourceArr;

// _delegate = newsListVC
@property(nonatomic, weak) id<ADCellDelegate> delegate;

@end
