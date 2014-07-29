//
//  TestViewControlerViewController.m
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "TestViewControlerViewController.h"
#import "RestKitManager.h"
#import "UserRequest.h"
#import "GPSManager.h"

@interface TestViewControlerViewController ()

@property(nonatomic, retain) GPSManager *gpsManager;

@end

@implementation TestViewControlerViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [GPSManager startUpdatingLocation];
}

- (IBAction)onClickList:(id)sender {
  [RestKitManager ticketList];
}

- (IBAction)onClickCreate:(id)sender {
  UserRequest *userRequest = [[UserRequest alloc] init];

  userRequest.phoneNumber = @"15827239028";
  userRequest.title = @"求购PS4";
  userRequest.description = @"高价求购PS4";
  userRequest.location = [[Location alloc] initWithX:113.41 andY:29.58];
  userRequest.privatePassword = @"123456";

  [RestKitManager create:userRequest];
}

@end
