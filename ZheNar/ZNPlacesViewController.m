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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowPlace"]) {
                [segue.destinationViewController setPlace:[self.events objectAtIndex:indexPath.row]];
            }
        }
    }
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.events[row] title];
}

@end
