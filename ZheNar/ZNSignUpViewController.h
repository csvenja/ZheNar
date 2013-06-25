//
//  ZNSignUpViewController.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-25.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNNetwork.h"

@interface ZNSignUpViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *studentName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITableViewCell *signUp;

@end
