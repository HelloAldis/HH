//
//  GPSManager.h
//  TestRest
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GPSManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic, retain) CLLocationManager *locationMgr;
//@property (nonatomic, retain) MKReverseGeocoder* reverseGeocoder;
@property(nonatomic, retain) CLGeocoder *clGeocoder; // iso 5.0及5.0以上SDK版本使用

// location detect
- (void)UpdateLocationLatLng;

@end