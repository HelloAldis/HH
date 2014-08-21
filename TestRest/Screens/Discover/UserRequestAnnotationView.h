//
//  UserRequestAnnotationView.h
//  TestRest
//
//  Created by KindAzrael on 14-8-13.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "BMKAnnotationView.h"

@class NearResponse;

@interface UserRequestAnnotationView : UIView

@property(weak, nonatomic) IBOutlet UILabel *lblTitle;

+ (instancetype)userRequestAnnotationViewWith:(NearResponse *)nearResponse;

@end
