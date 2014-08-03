//
//  UserRequstViewController.m
//  TestRest
//
//  Created by KindAzrael on 14-7-31.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "UserRequestViewController.h"
#import "UserRequest.h"
#import "TUUserDefaults+Properties.h"
#import "RestKitManager.h"
#import "Location.h"
#import "Response.h"

@interface UserRequestViewController ()

@property(weak, nonatomic) IBOutlet UITextField *fldTitle;
@property(weak, nonatomic) IBOutlet UITextView *textDescription;
@property(weak, nonatomic) IBOutlet UITextField *fldPhone;
@property(weak, nonatomic) IBOutlet UITextField *fldPassword;

@end

@implementation UserRequestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"新建需求";
}

- (IBAction)onClickCreate:(id)sender {
  UserRequest *userRequest = [[UserRequest alloc] init];
  userRequest.title = self.fldTitle.text;
  userRequest.description = self.textDescription.text;
  userRequest.phoneNumber = self.fldPhone.text;
  userRequest.privatePassword = self.fldPassword.text;
  userRequest.location = [[Location alloc] initWithLongitude:[TUUserDefaults standardUserDefaults].lastestLongitude
                                                 andLatitude:[TUUserDefaults standardUserDefaults].lastestLatitude];
  [RestKitManager create:userRequest
                 success:^(Response *response) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:response.status
                                                                     message:response.message
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                 }
                 failure:nil];
}

@end
