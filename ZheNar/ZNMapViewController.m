//
//  ZNMapViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNMapViewController.h"
#import "ZNSignInViewController.h"

NSInteger const kZNMapRegionDistance = 750;
CLLocationCoordinate2D const kZNMapCenter = {30.3015022222222, 120.08633333333};

@interface ZNMapViewController () <UIAlertViewDelegate>

@end

@implementation ZNMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
}

- (void)updateButton
{
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (user) {
        self.barButton.title = user[@"username"];
    }
    else {
        self.barButton.title = @"Sign In";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateButton];
    
    [[ZNNetwork me] requestPlaceListWithSuccess:^(NSArray *places) {
        self.places = places;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(kZNMapCenter, kZNMapRegionDistance, kZNMapRegionDistance);
        [self.mapView setRegion:region animated:NO];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotations:self.places];
    } failure:^(NSError *error) {
        ;
    }];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView removeAnnotation:self.userPlace];
    self.userPlace = [[ZNPlace alloc] init];
    self.userPlace.coordinate = self.mapView.userLocation.coordinate;
    [self.mapView addAnnotation:self.userPlace];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    if (annotation == self.userPlace) {
        annotationView.pinColor = MKPinAnnotationColorGreen;
    }
    else {
        annotationView.pinColor = MKPinAnnotationColorRed;
    }
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    return annotationView;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self.mapView selectAnnotation:self.places[2] animated:YES];
}

- (IBAction)signInOrOut:(UIBarButtonItem *)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        [self updateButton];
    }
    else {
        [self performSegueWithIdentifier:@"Sign In" sender:sender];
    }
}


@end
