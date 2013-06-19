//
//  ZNEventList.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventList.h"

NSString * const baseURL = @"http://42.121.18.11:24601/";

@implementation ZNEventList

+ (ZNEventList *)me
{
    static ZNEventList *theOnly = nil;
    
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{theOnly = [[self alloc] init];});
    return theOnly;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        [self.httpClient setParameterEncoding:AFJSONParameterEncoding];
        
        ZNEvent *eventsForTest = [[ZNEvent alloc] init];
        eventsForTest.name = @"SE & B/S Overtime";
        eventsForTest.type = [[ZNEventType alloc] init];
        eventsForTest.type.name = @"Study";
        eventsForTest.organization = @"DDP";
        eventsForTest.host = [[ZNUser alloc] init];
        eventsForTest.host.name = @"Master";
        eventsForTest.description = @"Time is grade!";
        
        eventsForTest.place = [[ZNPlace alloc] init];
        eventsForTest.place.name = @"Meng Minwei Building";
        eventsForTest.detailedPlace = @"218";
        eventsForTest.startTime = [NSDate date];
        eventsForTest.endTime = [NSDate date];
        
        eventsForTest.followerCount = 4;
        
        self.eventList = @[eventsForTest, eventsForTest];
    }
    return self;
}

- (void)requestJSONWithPath:(NSString *)path success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSMutableURLRequest *request = [self.httpClient requestWithMethod:@"GET" path:path parameters:nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed to get JSON: %@", [error userInfo]);
        failure(error);
    }];
    [operation start];
}

- (void)requestEventListWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
{
    [self requestJSONWithPath:@"miaow/" success:^(id JSON) {
        success(self.eventList);
    } failure:failure];
}

@end