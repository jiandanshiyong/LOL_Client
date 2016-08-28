//
//  HeroModel+CoreDataProperties.h
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HeroModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeroModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *myId; //关键字
@property (nullable, nonatomic, retain) NSString *name_c;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *img;
@property (nullable, nonatomic, retain) NSString *tags;

@end

NS_ASSUME_NONNULL_END
