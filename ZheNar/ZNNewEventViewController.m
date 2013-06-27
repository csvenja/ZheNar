//
//  ZNNewEventViewController.m
//  ZheNar
//
//  Created by Xhacker on 2013-06-26.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNewEventViewController.h"

@interface ZNNewEventViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *startTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeField;
@property (strong, nonatomic) UIDatePicker *startDatePicker;
@property (strong, nonatomic) UIDatePicker *endDatePicker;

@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *placeField;
@property (strong, nonatomic) UIPickerView *categoryPicker;
@property (strong, nonatomic) UIPickerView *placePicker;

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *places;

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
    
    self.categoryPicker = [[UIPickerView alloc] init];
    self.categoryPicker.delegate = self;
    self.categoryPicker.dataSource = self;
    self.categoryField.inputView = self.categoryPicker;
    
    self.placePicker = [[UIPickerView alloc] init];
    self.placePicker.delegate = self;
    self.placePicker.dataSource = self;
    self.placeField.inputView = self.placePicker;
    
    self.categories = @[@"Study", @"Food", @"Entertainment", @"Living"];
    self.places = @[@"meow", @"baa", @"moo", @"woo"];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.categoryPicker) {
        return self.categories.count;
    }
    else if (pickerView == self.placePicker) {
        return self.places.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.categoryPicker) {
        return self.categories[row];
    }
    else if (pickerView == self.placePicker) {
        return self.places[row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.categoryPicker) {
        self.categoryField.text = self.categories[row];
    }
    else if (pickerView == self.placePicker) {
        self.placeField.text = self.places[row];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [self.tableView endEditing:YES];
    }
}

@end
