//
//  ZNEventDetailViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventDetailViewController.h"

@interface ZNEventDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *Name;
@property (weak, nonatomic) IBOutlet UITableViewCell *Type;
@property (weak, nonatomic) IBOutlet UITableViewCell *Organization;
@property (weak, nonatomic) IBOutlet UITableViewCell *Host;
@property (weak, nonatomic) IBOutlet UITableViewCell *Description;

@property (weak, nonatomic) IBOutlet UITableViewCell *Place;
@property (weak, nonatomic) IBOutlet UITableViewCell *DetailedPlace;
@property (weak, nonatomic) IBOutlet UITableViewCell *StartTime;
@property (weak, nonatomic) IBOutlet UITableViewCell *EndTime;

@property (weak, nonatomic) IBOutlet UITableViewCell *Follower;

@property (strong, nonatomic) NSArray *rowsInBasic;
@property (strong, nonatomic) NSMutableArray *availableRowsInBasic;
@property (strong, nonatomic) NSArray *rowsInDetail;
@property (strong, nonatomic) NSMutableArray *availableRowsInDetail;
@property (strong, nonatomic) NSArray *rowsInMore;
@property (strong, nonatomic) NSMutableArray *availableRowsInMore;

@end

@implementation ZNEventDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rowsInBasic = @[@"Name", @"Typee", @"Organization", @"Host", @"Description"];
    self.rowsInDetail = @[@"Place", @"DetailedPlace", @"StartTime", @"EndTime"];
    self.rowsInMore = @[@"Follower"];
}

enum section {
    basicInfoSection = 0,
    detailInfoSection,
    moreInfoSection,
    numOfSections
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == basicInfoSection) {
        self.availableRowsInBasic = [NSMutableArray new];
        for (NSString *rowName in self.rowsInBasic) {
            if ([[self.event valueForKey:rowName] length] > 0) {
                [self.availableRowsInBasic addObject:rowName];
            }
        }
        return self.availableRowsInBasic.count;
    }
    else if (section == detailInfoSection) {
        self.availableRowsInDetail = [NSMutableArray new];
        for (NSString *rowName in self.rowsInDetail) {
            if ([[self.event valueForKey:rowName] length] > 0) {
                [self.availableRowsInDetail addObject:rowName];
            }
        }
        return self.availableRowsInDetail.count;
    }
    else if (section == moreInfoSection) {
        self.availableRowsInMore = [NSMutableArray new];
        for (NSString *rowName in self.rowsInMore) {
            if ([[self.event valueForKey:rowName] length] > 0) {
                [self.availableRowsInMore addObject:rowName];
            }
        }
        return self.availableRowsInMore.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == basicInfoSection) {
        NSString *rowName = self.availableRowsInBasic[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.event valueForKey:rowName];
    }
    else if (indexPath.section == detailInfoSection) {
        NSString *rowName = self.availableRowsInDetail[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.event valueForKey:rowName];
    }
    else if (indexPath.section == moreInfoSection) {
        NSString *rowName = self.availableRowsInMore[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.event valueForKey:rowName];
    }
    
	return cell;
}


@end
