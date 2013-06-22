//
//  ZNPlaceDetailViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-21.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNPlaceDetailViewController.h"

@interface ZNPlaceDetailViewController ()

@end

@implementation ZNPlaceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.place.coordinate, 500, 500);
    [self.mapView setRegion:region animated:NO];
}

@end
