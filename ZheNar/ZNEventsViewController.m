//
//  ZNEventsViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventsViewController.h"

@interface ZNEventsViewController ()

@end

@implementation ZNEventsViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowEvent"]) {
                //[segue.destinationViewController setEvent:[self.events objectAtIndex:indexPath.row]];
                [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
            }
        }
    }
}

- (void)viewDidLoad
{
    ZNEvent *eventsForTest = [[ZNEvent alloc] init];
    eventsForTest.name = @"miaow";
    eventsForTest.host.name = @"svenja";
    _events = @[eventsForTest];
}

- (void)setEvents:(NSArray *)events
{
    _events = events;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.events[row] name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
	return cell;
}

@end
