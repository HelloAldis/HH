//
//  GPSManager.m
//  TestRest
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "GPSManager.h"
//#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Util.h"

@implementation GPSManager

- (id)init {
  self = [super init];
  if (self) {
    self.locationMgr = nil;
    [self UpdateLocationLatLng];
  }
  return self;
}

- (void)UpdateLocationLatLng {
  if (self.locationMgr == nil) {
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.delegate = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
  }

  [self.locationMgr startUpdatingLocation];
}

- (void)locationAddressWithCLLocation:(CLLocation *)locationGps {
  if (self.clGeocoder == nil) {
    self.clGeocoder = [[CLGeocoder alloc] init];
  }

  [self.clGeocoder reverseGeocodeLocation:locationGps
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            MKPlacemark *placemark = [placemarks objectAtIndex:0];
                            NSLog(@"%@", placemark);
                        }];
}

#pragma mark - location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  NSLog(@"Location error!");
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
  if (!newLocation) {
    [self locationManager:manager didFailWithError:NULL];
    return;
  }

  [manager stopUpdatingLocation];

  NSLog(@"current location: %f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);

  [self locationAddressWithCLLocation:newLocation];
}

@end