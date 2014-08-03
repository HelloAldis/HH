//
//  BaseViewController.m
//  TestRest
//
//  Created by KindAzrael on 14-8-1.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self.view endEditing:YES];
}

@end
