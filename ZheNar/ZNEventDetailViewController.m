//
//  ZNEventDetailViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventDetailViewController.h"

@interface ZNEventDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *organization;
@property (weak, nonatomic) IBOutlet UILabel *host;
@property (weak, nonatomic) IBOutlet UILabel *description;

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *detailedPlace;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *follower;


@end

@implementation ZNEventDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
}

@end
