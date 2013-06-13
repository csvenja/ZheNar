//
//  ZNEventDetailViewController.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-09.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNEvent.h"

@interface ZNEventDetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ZNEvent *event;

@end
