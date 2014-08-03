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
#import "Location.h"
#import "Response.h"

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
  userRequest.description = @"高价求购PS4。。。";
  userRequest.location = [[Location alloc] initWithLongitude:113.41 andLatitude:29.58];
  userRequest.privatePassword = @"123456";

  [RestKitManager create:userRequest
                 success:^(Response *response) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:response.status
                                                                     message:response.message
                                                                    delegate:nil
                                                           cancelButtonTitle:nil
                                                           otherButtonTitles:nil];
                     [alert show];
                 }
                 failure:nil];
}

@end
