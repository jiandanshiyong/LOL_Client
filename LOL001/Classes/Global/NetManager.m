//
//  NetManager.m
//  LOL001
//
//  Created by 张凯 on 14/7/5.
//  Copyright © 2014年 zk. All rights reserved.
//

//AFNetworking2.0 封装

#import "NetManager.h"


@implementation NetManager

+ (void)GET:(NSString *)urlStr
 parameters:(id)param
    success:(SuccessBlock)success
    failure:(FailureBlock)failure  {

    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    [manage GET:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
             success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)urlStr
 parameters:(id)param
    success:(SuccessBlock)success
    failure:(FailureBlock)failure  {
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manage POST:urlStr parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
