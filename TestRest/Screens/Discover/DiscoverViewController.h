//
//  DiscoverViewController.h
//  TestRest
//
//  Created by KindAzrael on 14-8-1.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BMapKit.h"

@interface DiscoverViewController
    : BaseViewController <UITableViewDataSource, UITableViewDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate>

@end
