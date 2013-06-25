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
    self.type.text = self.event.type.name;
    self.organization.text = self.event.organization;
    self.host.text = self.event.host.username;
    self.description.text = self.event.description;
    
    self.place.text = self.event.place.title;
    self.detailedPlace.text = self.event.detailedPlace;
    self.startTime.text = [NSDateFormatter localizedStringFromDate:self.event.startTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    self.endTime.text = [NSDateFormatter localizedStringFromDate:self.event.endTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    self.follower.text = [NSString stringWithFormat:@"%d", self.event.followerCount];
    
    [super viewDidLoad];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowPlace"]) {
                [segue.destinationViewController setPlace:self.event.place];
            }
        }
    }
}


@end
