//
//  ZNNewEventViewController.m
//  ZheNar
//
//  Created by Xhacker on 2013-06-26.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNewEventViewController.h"

@interface ZNNewEventViewController ()

@property (weak, nonatomic) IBOutlet UITextField *startTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeField;
@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;

@end

@implementation ZNNewEventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.startDatePicker = [[UIDatePicker alloc] init];
    self.startTimeField.inputView = self.startDatePicker;
    self.startDatePicker.minuteInterval = 15;
    [self.startDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    self.endDatePicker = [[UIDatePicker alloc] init];
    self.endTimeField.inputView = self.endDatePicker;
    self.endDatePicker.minuteInterval = 15;
    [self.endDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)cancelClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dateChanged
{
    if ([self.startTimeField isFirstResponder]) {
        self.startTimeField.text = [NSDateFormatter localizedStringFromDate:self.startDatePicker.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];

    }
    else if ([self.endTimeField isFirstResponder]) {
        self.endTimeField.text = [NSDateFormatter localizedStringFromDate:self.endDatePicker.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    }
}

@end
