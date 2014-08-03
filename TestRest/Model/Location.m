//
//  Location.m
//  TestRest
//
//  Created by KindAzrael on 14-7-27.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id)initWithLongitude:(double)longitude andLatitude:(double)latitude {
  if ((self = [super init]) != nil) {
    _type = @"Point";
    _coordinates =
        [NSArray arrayWithObjects:[NSNumber numberWithDouble:longitude], [NSNumber numberWithDouble:latitude], nil];
  }

  return self;
}

@end
