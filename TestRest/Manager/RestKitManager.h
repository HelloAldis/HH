//
//  RestKitManager.h
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRequest.h"

@interface RestKitManager : NSObject

+ (void)ticketList;
+ (void)create:(UserRequest *)userRequest;

@end
