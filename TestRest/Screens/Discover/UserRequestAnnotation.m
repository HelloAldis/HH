//
//  UserReqestAnnotation.m
//  TestRest
//
//  Created by KindAzrael on 14-8-17.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "UserRequestAnnotation.h"

@interface UserReqestAnnotation ()

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *userRequestId;

@end

@implementation UserReqestAnnotation
@synthesize coordinate;

- (id)initWithTitle:(NSString *)title andUserRequestId:(NSString *)userRequestId {
  if (self = [super init]) {
    _title = title;
    _userRequestId = userRequestId;
  }

  return self;
}

- (NSString *)subtitle {
  return nil;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
  self.coordinate = newCoordinate;
}

@end
