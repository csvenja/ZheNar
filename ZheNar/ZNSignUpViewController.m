//
//  ZNSignUpViewController.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-25.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNSignUpViewController.h"
#import "SVProgressHUD.h"

NSInteger const kSignUpButton = 0;

@interface ZNSignUpViewController ()

@end

@implementation ZNSignUpViewController

- (IBAction)cancelClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == kSignUpButton) {
        self.email.text = @"";
        self.username.text = @"";
        self.studentName.text = @"";
        self.password.text = @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    if (theCellClicked == self.signUp) {
        [self.email resignFirstResponder];
        [self.username resignFirstResponder];
        [self.studentName resignFirstResponder];
        [self.password resignFirstResponder];
        [SVProgressHUD showWithStatus:@"Connecting" maskType:SVProgressHUDMaskTypeBlack];
        [[ZNNetwork me] registerWithEmail:self.email.text username:self.username.text password:self.password.text studentName:self.studentName.text success:^(NSDictionary *user) {
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
            //[[self navigationController] popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:^{
                [[self navigationController] popToRootViewControllerAnimated:YES];
            }];
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [alert show];
            [SVProgressHUD dismiss];
        }];
    }
}

@end
