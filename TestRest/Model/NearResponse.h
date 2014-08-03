//
//  NearResponse.h
//  TestRest
//
//  Created by KindAzrael on 14-8-3.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserRequest;

@interface NearResponse : NSObject

@property(nonatomic, strong) NSString *dis;
@property(nonatomic, strong) UserRequest *userRequest;

@end
