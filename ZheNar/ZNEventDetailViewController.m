//
//  ZNEventDetailViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventDetailViewController.h"

@interface ZNEventDetailViewController ()



@end

@implementation ZNEventDetailViewController

- (void)viewDidLoad
{
    self.name.text = _event.name;
    self.type.text = _event.type.name;
    self.organization.text = _event.organization;
    self.host.text = _event.host.name;
    self.description.text = _event.description;
    
    self.place.text = _event.place.name;
    self.detailedPlace.text = _event.detailedPlace;
    self.startTime.text = [NSDateFormatter localizedStringFromDate:_event.startTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    self.endTime.text = [NSDateFormatter localizedStringFromDate:_event.endTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    self.follower.text = [NSString stringWithFormat:@"%d", _event.followerCount];
    
    [super viewDidLoad];
}

@end
