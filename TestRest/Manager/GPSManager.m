//
//  GPSManager.m
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "GPSManager.h"
#import "TUUserDefaults+Properties.h"

@implementation GPSManager

- (id)init {
  if ((self = [super init]) != nil) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  }

  return self;
}

+ (GPSManager *)sharedInstance {
  static GPSManager *gpsManager;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ gpsManager = [[GPSManager alloc] init]; });
  return gpsManager;
}

+ (void)startUpdatingLocation {
  [[GPSManager sharedInstance] startUpdatingLocation];
}

+ (double)lastestLongitude {
  return [TUUserDefaults standardUserDefaults].lastestLongitude;
}

+ (double)lastestLatitude {
  return [TUUserDefaults standardUserDefaults].lastestLatitude;
}

- (void)startUpdatingLocation {
  [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  NSLog(@"longitude %f", [[locations lastObject] coordinate].longitude);
  NSLog(@"latitude %f", [[locations lastObject] coordinate].latitude);

  // Save to user default
  [TUUserDefaults standardUserDefaults].lastestLongitude = [[locations lastObject] coordinate].longitude;
  [TUUserDefaults standardUserDefaults].lastestLatitude = [[locations lastObject] coordinate].latitude;

  [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"error: %@", [error localizedDescription]);
}

@end
