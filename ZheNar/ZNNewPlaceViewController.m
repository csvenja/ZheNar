//
//  ZNNewPlaceViewController.m
//  ZheNar
//
//  Created by Xhacker on 2013-06-26.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNewPlaceViewController.h"

@interface ZNNewPlaceViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property NSArray *categories;

@end

@implementation ZNNewPlaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.categories = @[@"Study", @"Food", @"Entertainment", @"Living"];
}

- (IBAction)cancelClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.categories[row];
}

@end
