//
//  ZNPlaceDetailViewController.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-21.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ZNPlace.h"

@interface ZNPlaceDetailViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) ZNPlace *place;

@end
