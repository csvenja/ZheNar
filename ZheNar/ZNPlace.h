//
//  ZNPlace.h
//  ZheNar
//
//  Created by C.Svenja on 2013-05-23.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNPlaceType.h"

@interface ZNPlace : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) CGPoint position;
@property (strong, nonatomic) ZNPlaceType *type;
@property (strong, nonatomic) NSString *description;

@end
