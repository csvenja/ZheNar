//
//  ZNEventDetailViewController.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNEvent.h"
#import "ZNEventType.h"
#import "ZNUser.h"
#import "ZNPlace.h"
#import "ZNPlaceDetailViewController.h"

@interface ZNEventDetailViewController : UITableViewController

@property (weak, nonatomic) ZNEvent *event;

@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *organization;
@property (weak, nonatomic) IBOutlet UILabel *host;
@property (weak, nonatomic) IBOutlet UILabel *description;

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UITableViewCell *placeCell;
@property (weak, nonatomic) IBOutlet UILabel *detailedPlace;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *follower;


@end
