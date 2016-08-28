//
//  HeroModel.m
//  LOL001
//
//  Created by 张凯 on 16/7/8.
//  Copyright © 2014年 zk. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

// Insert code here to add functionality to your managed object subclass

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.myId = value;
    }
}



@end
