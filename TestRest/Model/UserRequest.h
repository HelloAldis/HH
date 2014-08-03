//
//  UserRequest.h
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface UserRequest : NSObject

@property(nonatomic, retain) NSString *_id;
@property(nonatomic, retain) NSString *phoneNumber;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) Location *location;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *date;
@property(nonatomic, retain) NSString *privatePassword;
@property(nonatomic, retain) NSString *status;

@end
