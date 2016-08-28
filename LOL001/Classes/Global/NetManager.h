//
//  NetManager.h
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface NetManager : NSObject

+ (void)GET:(NSString *)urlStr
 parameters:(id)param
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

+ (void)POST:(NSString *)urlStr
  parameters:(id)param
     success:(SuccessBlock)success
     failure:(FailureBlock)failure;

@end
