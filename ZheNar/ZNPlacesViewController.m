//
//  ZNPlaceViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNPlacesViewController.h"

@interface ZNPlacesViewController ()

@end

@implementation ZNPlacesViewController

- (void)configure
{
    [[ZNNetwork me] requestPlaceListWithSuccess:^(NSArray *events) {
        self.events = events;
    } failure:^(NSError *error) {
        ;
    }];
}

@end
