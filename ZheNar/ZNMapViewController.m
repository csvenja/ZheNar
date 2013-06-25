//
//  ZNMapViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNMapViewController.h"

@interface ZNMapViewController () <UIAlertViewDelegate>

@end

@implementation ZNMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[ZNNetwork me] requestPlaceListWithSuccess:^(NSArray *places) {
        self.places = places;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self.places[2] coordinate], 1500, 1500);
        [self.mapView setRegion:region animated:NO];
        [self.mapView addAnnotations:self.places];
    } failure:^(NSError *error) {
        ;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self.mapView selectAnnotation:self.places[2] animated:YES];
    ZNUser *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (user) {
        self.barButton.title = user.username;
        self.segueToPerform = @"User Info";
    }
    else {
        self.barButton.title = @"Sign In";
        self.segueToPerform = @"Sign In";
    }
}


@end
