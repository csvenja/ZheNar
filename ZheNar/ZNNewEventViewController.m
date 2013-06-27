//
//  ZNNewEventViewController.m
//  ZheNar
//
//  Created by Xhacker on 2013-06-26.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNewEventViewController.h"
#import "ZNNetwork.h"
#import "SVProgressHUD.h"
#import "ISO8601DateFormatter.h"

@interface ZNNewEventViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *organizationField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

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

@property (weak, nonatomic) IBOutlet UITableViewCell *creatEventCell;

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
    
#warning FIXME
    [[ZNNetwork me] requestEventTypeWithSuccess:^(NSArray *typeList) {
        self.categories = typeList;
    } failure:nil];

    [[ZNNetwork me] requestPlaceListWithSuccess:^(NSArray *placeList) {
        self.places = placeList;
    } failure:nil];
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
        return self.categories[row][@"name"];
    }
    else if (pickerView == self.placePicker) {
        return ((ZNPlace *)self.places[row]).title;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.categoryPicker) {
        self.categoryField.text = self.categories[row][@"name"];
    }
    else if (pickerView == self.placePicker) {
        self.placeField.text = ((ZNPlace *)self.places[row]).title;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    if (theCellClicked == self.creatEventCell) {
        [SVProgressHUD showWithStatus:@"Connecting" maskType:SVProgressHUDMaskTypeClear];
        
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        formatter.includeTime = YES;
        NSDictionary *dictionary = @{
                                     @"name": self.nameField.text,
                                     @"description": self.descriptionField.text,
                                     @"organization": self.organizationField.text,
                                     @"start_time": [formatter stringFromDate:self.startDatePicker.date],
                                     @"end_time": [formatter stringFromDate:self.endDatePicker.date],
#warning FIXME
                                     @"place_id": @"28",
                                     @"event_type_id": self.categories[[self.categoryPicker selectedRowInComponent:0]][@"id"],
                                     @"address": self.addressField.text
                                     };
        
        [[ZNNetwork me] createEventWithDictionary:dictionary success:^(void) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [SVProgressHUD dismiss];
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [self.tableView endEditing:YES];
    }
}

@end
