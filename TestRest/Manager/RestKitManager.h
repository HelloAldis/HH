//
//  RestKitManager.h
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserRequest;
@class Response;

@interface RestKitManager : NSObject

+ (void)ticketList;
+ (void)create:(UserRequest *)userRequest
       success:(void (^)(Response *response))success
       failure:(void (^)(Response *response))failure;
+ (void)near:(double)longitude
    latitude:(double)latitude
     success:(void (^)(NSArray *array))success
     failure:(void (^)(NSError *error))failure;

@end
