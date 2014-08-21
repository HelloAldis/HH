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
#import "NearResponse.h"
#import "UserRequest.h"
#import <CoreLocation/CoreLocation.h>
#import "UserRequestAnnotationView.h"
#import "MyLocationAnnotation.h"

#define kListSegmented 0
#define kMapSegmented 1

@interface DiscoverViewController ()

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet BMKMapView *mapView;

@property(nonatomic, strong) NSArray *datasource;

@end

@implementation DiscoverViewController

#pragma mark - life cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)viewWillAppear:(BOOL)animated {
  [self.mapView viewWillAppear];
  [self.mapView setZoomLevel:15];
  self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.title = @"发现";
  [RestKitManager near:[TUUserDefaults standardUserDefaults].lastestLongitude
              latitude:[TUUserDefaults standardUserDefaults].lastestLatitude
               success:^(NSArray *array) {
                   self.datasource = array;
                   [self.tableView reloadData];
                   [self addAnnotation];
               }
               failure:nil];

  [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([TUUserDefaults standardUserDefaults].lastestLatitude,
                                                               [TUUserDefaults standardUserDefaults].lastestLongitude)
                           animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.mapView viewWillDisappear];
  self.mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - event
- (IBAction)onClickSegmented:(id)sender {
  UISegmentedControl *segmented = sender;
  switch (segmented.selectedSegmentIndex) {
  case kListSegmented:
    self.tableView.hidden = NO;
    self.mapView.hidden = YES;
    break;
  case kMapSegmented:
    self.tableView.hidden = YES;
    self.mapView.hidden = NO;
  default:
    break;
  }
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

  NearResponse *nearResponse = [self.datasource objectAtIndex:indexPath.row];
  cell.lblDis.text = [NSString stringWithFormat:@"%.1f千米", nearResponse.dis];
  cell.lblTitle.text = nearResponse.obj.title;
  cell.lblDescription.text = nearResponse.obj.description;

  return cell;
}

#pragma mark - BMKMapView delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
  NSString static *myLocationAnnotationViewID = @"myLocationAnnotationViewID";
  NSString static *userRequestAnnotationViewID = @"userRequestAnnotationViewID";
  BMKAnnotationView *newAnnotation = nil;

  if ([annotation isKindOfClass:[MyLocationAnnotation class]]) {
    newAnnotation =
        [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:myLocationAnnotationViewID];
    newAnnotation.draggable = NO;
    newAnnotation.image = [UIImage imageNamed:@"icon_center_point"];
  } else if ([annotation isKindOfClass:[NearResponse class]]) {
    newAnnotation =
        [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userRequestAnnotationViewID];
    newAnnotation.draggable = NO;
    newAnnotation.image = [UIImage imageNamed:@"个人"];
    UIView *customView = [UserRequestAnnotationView userRequestAnnotationViewWith:annotation];
    newAnnotation.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:customView];
  }

  return newAnnotation;
}

#pragma mark - inner method
- (void)addAnnotation {
  CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([TUUserDefaults standardUserDefaults].lastestLatitude,
                                                           [TUUserDefaults standardUserDefaults].lastestLongitude);
  MyLocationAnnotation *myLocationAnnotation = [[MyLocationAnnotation alloc] initWithCoordinate:coor];
  [_mapView addAnnotation:myLocationAnnotation];

  for (NearResponse *nearResponse in self.datasource) {
    [_mapView addAnnotation:nearResponse];
  }
}
@end
