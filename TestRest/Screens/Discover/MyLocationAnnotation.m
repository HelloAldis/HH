//
//  MyLocationAnnotation.m
//  TestRest
//
//  Created by KindAzrael on 14-8-17.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "MyLocationAnnotation.h"

@implementation MyLocationAnnotation

@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
  if (self = [super init]) {
    _coordinate = coordinate;
  }

  return self;
}

- (NSString *)title {
  return @"我";
}

- (NSString *)subtitle {
  return nil;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
  self.coordinate = newCoordinate;
}

@end
