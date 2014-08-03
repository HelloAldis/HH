//
//  RestKitManager.m
//  TestRest
//
//  Created by KindAzrael on 14-7-26.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "RestKitManager.h"
#import "Response.h"
#import "UserRequest.h"
#import "NearResponse.h"

#define kCreatePath @"/ticket/create"
#define kNearPath @"/ticket/near"

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
  DDLogVerbose(@"RestKitManager init");

  if ((self = [super init]) != nil) {
    _rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000"]];
    [self initCreate];
    [self initNear];
  }

  return self;
}

- (void)initCreate {
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

  RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Response class]];
  [responseMapping addAttributeMappingsFromArray:@[ @"status", @"message" ]];
  NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
  RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                          method:RKRequestMethodAny
                                                                                     pathPattern:kCreatePath
                                                                                         keyPath:nil
                                                                                     statusCodes:statusCodes];
  [_rkObjectManager addResponseDescriptor:responseDescriptor];
}

- (void)initNear {
  RKObjectMapping *nearResponseMapping = [RKObjectMapping mappingForClass:[UserRequest class]];
  [nearResponseMapping addAttributeMappingsFromDictionary:@{
    @"_id" : @"_id",
    @"phoneNumber" : @"phoneNumber",
    @"location.type" : @"location.type",
    @"location.coordinates" : @"location.coordinates",
    @"description" : @"description",
    @"privatePassword" : @"privatePassword",
    @"title" : @"title",
    @"status" : @"status",
    @"date" : @"date"
  }];

  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NearResponse class]];
  [mapping addAttributeMappingsFromDictionary:@{ @"dis" : @"dis", @"obj" : @"userRequest" }];

  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                  method:RKRequestMethodAny
                                                                             pathPattern:kNearPath
                                                                                 keyPath:nil
                                                                             statusCodes:nil];

  RKResponseDescriptor *nearResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:nearResponseMapping
                                                                                              method:RKRequestMethodAny
                                                                                         pathPattern:kNearPath
                                                                                             keyPath:@"obj"
                                                                                         statusCodes:nil];

  [_rkObjectManager addResponseDescriptor:nearResponseDescriptor];
//  [_rkObjectManager addResponseDescriptor:descriptor];
}

+ (void)ticketList {
  [instance ticketList];
}

- (void)ticketList {
  [self.rkObjectManager getObject:nil
      path:@"/ticket/list"
      parameters:nil
      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          DDLogVerbose(@"%@", [mappingResult dictionary]);
          DDLogVerbose(@"%@", [mappingResult firstObject]);
          DDLogVerbose(@"%@", [mappingResult array]);
          DDLogVerbose(@"%@", [mappingResult description]);
          Response *r = [mappingResult firstObject];
          DDLogVerbose(@"%@", [r status]);
      }
      failure:^(RKObjectRequestOperation *operation, NSError *error) { DDLogError(@"%@", error); }];
}

+ (void)create:(UserRequest *)userRequest
       success:(void (^)(Response *response))success
       failure:(void (^)(Response *response))failure {
  [instance create:userRequest success:success failure:failure];
}

- (void)create:(UserRequest *)userRequest
       success:(void (^)(Response *response))success
       failure:(void (^)(Response *response))failure {
  [self.rkObjectManager postObject:userRequest
      path:kCreatePath
      parameters:nil
      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          DDLogVerbose(@"%@", [mappingResult dictionary]);
          DDLogVerbose(@"%@", [mappingResult firstObject]);
          DDLogVerbose(@"%@", [mappingResult array]);
          DDLogVerbose(@"%@", [mappingResult description]);
          Response *r = [mappingResult firstObject];
          DDLogVerbose(@"%@", [r status]);
          success(r);
      }
      failure:^(RKObjectRequestOperation *operation, NSError *error) { DDLogError(@"%@", error); }];
}

+ (void)near:(double)longitude
    latitude:(double)latitude
     success:(void (^)(NSArray *array))success
     failure:(void (^)(NSError *error))failure {
  [instance near:longitude latitude:latitude success:success failure:failure];
}

- (void)near:(double)longitude
    latitude:(double)latitude
     success:(void (^)(NSArray *array))success
     failure:(void (^)(NSError *error))failure {
  NSString *longStr = [NSString stringWithFormat:@"%f", longitude];
  NSString *latStr = [NSString stringWithFormat:@"%f", latitude];

  [self.rkObjectManager getObjectsAtPath:kNearPath
      parameters:@{
        @"long" : longStr,
        @"lat" : latStr
      }
      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
          DDLogVerbose(@"%@", [mappingResult dictionary]);
          DDLogVerbose(@"%@", [mappingResult firstObject]);
          DDLogVerbose(@"%@", [mappingResult array]);
          DDLogVerbose(@"%@", [mappingResult description]);
          success([mappingResult array]);
      }
      failure:^(RKObjectRequestOperation *operation, NSError *error) { DDLogError(@"%@", error); }];
}

@end
