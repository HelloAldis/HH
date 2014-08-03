//
//  MainViewController.m
//  TestRest
//
//  Created by KindAzrael on 14-8-2.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "MainViewController.h"
#import "UserRequestViewController.h"
#import "DiscoverViewController.h"

#define kUserRequestTabBarTag 1
#define kDiscoverTabBarTag 2

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    UserRequestViewController *userRequestViewController =
        [[UserRequestViewController alloc] initWithNibName:nil bundle:nil];
    userRequestViewController.tabBarItem =
        [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:kUserRequestTabBarTag];
    UINavigationController *nav1 =
        [[UINavigationController alloc] initWithRootViewController:userRequestViewController];

    DiscoverViewController *discorverViewController = [[DiscoverViewController alloc] initWithNibName:nil bundle:nil];
    discorverViewController.tabBarItem =
        [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:kDiscoverTabBarTag];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:discorverViewController];

    self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

@end
