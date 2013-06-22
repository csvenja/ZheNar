//
//  ZNPlace.h
//  ZheNar
//
//  Created by C.Svenja on 2013-05-23.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ZNPlaceType.h"

@interface ZNPlace : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) ZNPlaceType *type;
@property (strong, nonatomic) NSString *subtitle;

@end
