//
//  UserRequestAnnotationView.m
//  TestRest
//
//  Created by KindAzrael on 14-8-13.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "UserRequestAnnotationView.h"
#import "NearResponse.h"
#import "UserRequest.h"

@implementation UserRequestAnnotationView

+ (instancetype)userRequestAnnotationViewWith:(NearResponse *)nearResponse {
  UserRequestAnnotationView *view =
      [[NSBundle mainBundle] loadNibNamed:@"UserRequestAnnotationView" owner:nil options:nil].lastObject;

  view.lblTitle.text = nearResponse.obj.title;
  return view;
}

@end
