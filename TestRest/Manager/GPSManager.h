//
//  GPSManager.h
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GPSManager : NSObject <CLLocationManagerDelegate>

@property(nonatomic, retain) CLLocationManager *locationManager;

+ (void)startUpdatingLocation;

@end
