//
//  DiscoverViewController.m
//  TestRest
//
//  Created by KindAzrael on 14-8-1.
//  Copyright (c) 2014年 KindAzrael. All rights reserved.
//

#import "DiscoverViewController.h"
#import "RestkitManager.h"
#import "TUUserDefaults+Properties.h"
#import "UserRequestTableViewCell.h"
#import "UserRequest.h"

@interface DiscoverViewController ()

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *datasource;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [RestKitManager near:[TUUserDefaults standardUserDefaults].lastestLongitude
              latitude:[TUUserDefaults standardUserDefaults].lastestLatitude
               success:^(NSArray *array) {
                   self.datasource = array;
                   [self.tableView reloadData];
               }
               failure:nil];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.datasource.count;
}

#pragma mark - table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"UserRequestTableViewCell";
  UserRequestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil) {
    cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil].lastObject;
  }

  UserRequest *userRquest = [self.datasource objectAtIndex:indexPath.row];
  cell.lblTitle.text = userRquest.title;
  cell.lblDescription.text = userRquest.description;

  return cell;
}
@end
