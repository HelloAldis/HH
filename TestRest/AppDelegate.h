//
//  AppDelegate.h
//  TestRest
//
//  Created by KindAzrael on 14-7-20.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) MainViewController *mainViewController;
@property(nonatomic, strong) BMKMapManager *mapManager;

@end
