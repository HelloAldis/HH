//
//  NearResponse.m
//  TestRest
//
//  Created by KindAzrael on 14-8-3.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "NearResponse.h"
#import "UserRequest.h"
#import "Location.h"

@implementation NearResponse

#pragma mark - Baidu Annotaion extend
- (NSString *)title {
  return self.obj.title;
}

- (NSString *)subtitle {
  return self.obj.description;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
  // Do nothing, do not allow to change annotation coordiante;
}

- (CLLocationCoordinate2D)coordinate {
  return CLLocationCoordinate2DMake([[self.obj.location.coordinates lastObject] doubleValue],
                                    [[self.obj.location.coordinates firstObject] doubleValue]);
}

@end
