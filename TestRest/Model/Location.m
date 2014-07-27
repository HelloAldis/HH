//
//  Location.m
//  TestRest
//
//  Created by KindAzrael on 14-7-27.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id)initWithX:(double)x andY:(double)y {
  if ((self = [super init]) != nil) {
    _type = @"Point";
    _coordinates = [NSArray arrayWithObjects:[NSNumber numberWithDouble:x], [NSNumber numberWithDouble:y], nil];
  }

  return self;
}

@end
