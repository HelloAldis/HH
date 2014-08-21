//
//  GPSManager.m
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "GPSManager.h"
#import "TUUserDefaults+Properties.h"
#import "BMapKit.h"

@interface GPSManager ()

@property(nonatomic, strong) BMKLocationService *bmkLocationService;

@end

@implementation GPSManager

- (id)init {
  if ((self = [super init]) != nil) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    _bmkLocationService = [[BMKLocationService alloc] init];
    _bmkLocationService.delegate = self;
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
  //  [self.locationManager startUpdatingLocation];
  [self.bmkLocationService startUserLocationService];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  DDLogDebug(@"longitude %f", [[locations lastObject] coordinate].longitude);
  DDLogDebug(@"latitude %f", [[locations lastObject] coordinate].latitude);

  // Save to user default
  [TUUserDefaults standardUserDefaults].lastestLongitude = [[locations lastObject] coordinate].longitude;
  [TUUserDefaults standardUserDefaults].lastestLatitude = [[locations lastObject] coordinate].latitude;

  [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  DDLogError(@"Apple location error: %@", [error localizedDescription]);
}

#pragma mark - BMK Location service delegate
- (void)willStartLocatingUser {
  DDLogDebug(@"start to locate user");
}

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation {
  DDLogDebug(@"didUpdateUserLocation lat %f,long %f", userLocation.location.coordinate.latitude,
             userLocation.location.coordinate.longitude);

  [TUUserDefaults standardUserDefaults].lastestLongitude = userLocation.location.coordinate.longitude;
  [TUUserDefaults standardUserDefaults].lastestLatitude = userLocation.location.coordinate.latitude;

  [self.bmkLocationService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
  DDLogError(@"Can not get location error: %@", [error localizedDescription]);
}

@end
