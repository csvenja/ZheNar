//
//  ZNEventsViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventsViewController.h"
#import "ZNEventDetailViewController.h"

@interface ZNEventsViewController ()

@end

@implementation ZNEventsViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowEvent"]) {
                [segue.destinationViewController setEvent:[self.events objectAtIndex:indexPath.row]];
                [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
            }
        }
    }
}

- (void)viewDidLoad
{
    ZNEvent *eventsForTest = [[ZNEvent alloc] init];
    eventsForTest.name = @"SE & B/S Overtime";
    eventsForTest.type = [[ZNEventType alloc] init];
    eventsForTest.type.name = @"Study";
    eventsForTest.organization = @"DDP";
    eventsForTest.host = [[ZNUser alloc] init];
    eventsForTest.host.name = @"Master";
    eventsForTest.description = @"Time is grade!";
    
    eventsForTest.place = [[ZNPlace alloc] init];
    eventsForTest.place.name = @"Meng Minwei Building";
    eventsForTest.detailedPlace = @"218";
    eventsForTest.startTime = [NSDate date];
    eventsForTest.endTime = [NSDate date];
    
    eventsForTest.followerCount = 4;
    
    _events = @[eventsForTest, eventsForTest];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
	return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [super viewWillAppear:animated];
}

@end
