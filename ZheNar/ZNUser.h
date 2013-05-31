//
//  ZNUser.h
//  ZheNar
//
//  Created by C.Svenja on 2013-05-31.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNUser : NSObject

@property (nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString * studentID;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * gender;
@property (strong, nonatomic) NSDate * register_time;

@end