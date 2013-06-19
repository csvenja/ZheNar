//
//  ZNEventList.h
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "ZNEvent.h"
#import "ZNEventType.h"
#import "ZNPlace.h"

@interface ZNEventList : NSObject

@property (strong, nonatomic) NSMutableArray *eventList;
@property AFHTTPClient *httpClient;

+ (ZNEventList *)me;
- (void)requestJSONWithPath:(NSString *)path success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)requestEventListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;

@end
