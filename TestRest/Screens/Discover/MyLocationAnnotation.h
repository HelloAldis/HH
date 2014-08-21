//
//  MyLocationAnnotation.h
//  TestRest
//
//  Created by KindAzrael on 14-8-17.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface MyLocationAnnotation : NSObject <BMKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
