//
//  ZNEventsViewController.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//
// Will call setEventDetail: as part of any "Show Event" segue

#import <UIKit/UIKit.h>
#import "ZNEvent.h"
#import "ZNEventType.h"
#import "ZNUser.h"
#import "ZNPlace.h"
#import "ZNNetwork.h"

@interface ZNEventsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
