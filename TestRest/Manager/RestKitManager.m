//
//  RestKitManager.m
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "RestKitManager.h"
#import "Response.h"

@interface RestKitManager ()

@property(nonatomic, retain) RKObjectManager *rkObjectManager;

@end

@implementation RestKitManager

static RestKitManager *instance;

+ (RestKitManager *)sharedInstance {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ instance = [[RestKitManager alloc] init]; });

  return instance;
}

+ (void)initialize {
  [RestKitManager sharedInstance];
  RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
}

- (id)init {
  NSLog(@"RestKitManager init");

  if ((self = [super init]) != nil) {
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Response class]];
    [responseMapping addAttributeMappingsFromArray:@[ @"status" ]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:statusCodes];

    _rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000"]];
    [_rkObjectManager addResponseDescriptor:responseDescriptor];

    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:@{
      @"phoneNumber" : @"phoneNumber",
      @"location.type" : @"location.type",
      @"location.coordinates" : @"location.coordinates",
      @"description" : @"description",
      @"privatePassword" : @"privatePassword",
      @"title" : @"title"
    }];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping
                                                                                   objectClass:[UserRequest class]
                                                                                   rootKeyPath:@"userRequest"
                                                                                        method:RKRequestMethodPOST];
    [_rkObjectManager addRequestDescriptor:requestDescriptor];
  }

  return self;
}

+ (void)ticketList {
  [instance ticketList];
}

- (void)ticketList {
  [self.rkObjectManager getObject:nil
      path:@"/ticket/list"
      parameters:nil
      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          NSLog(@"%@", [mappingResult dictionary]);
          NSLog(@"%@", [mappingResult firstObject]);
          NSLog(@"%@", [mappingResult array]);
          NSLog(@"%@", [mappingResult description]);
          Response *r = [mappingResult firstObject];
          NSLog(@"%@", [r status]);
      }
      failure:^(RKObjectRequestOperation *operation, NSError *error) { NSLog(@"%@", error); }];
}

+ (void)create:(UserRequest *)userRequest {
  [instance create:userRequest];
}

- (void)create:(UserRequest *)userRequest {
  [self.rkObjectManager postObject:userRequest
      path:@"/ticket/create"
      parameters:nil
      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          NSLog(@"%@", [mappingResult dictionary]);
          NSLog(@"%@", [mappingResult firstObject]);
          NSLog(@"%@", [mappingResult array]);
          NSLog(@"%@", [mappingResult description]);
          Response *r = [mappingResult firstObject];
          NSLog(@"%@", [r status]);
      }
      failure:^(RKObjectRequestOperation *operation, NSError *error) { NSLog(@"%@", error); }];
}

@end
