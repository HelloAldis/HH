//
//  NearResponse.h
//  TestRest
//
//  Created by KindAzrael on 14-8-3.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@class UserRequest;

@interface NearResponse : NSObject <BMKAnnotation>

@property(nonatomic, assign) float dis;
@property(nonatomic, strong) UserRequest *obj;

@end
