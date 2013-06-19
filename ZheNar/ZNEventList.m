//
//  ZNEventList.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNEventList.h"

NSString * const baseURL = @"http://localhost";

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

- (void)requestEventListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;
{
    [self requestJSONWithPath:@"/ZheNar/event/test.json" success:^(id JSON) {
        self.eventList = [[NSMutableArray alloc] init];
        for (id item in JSON) {
            ZNEvent *event = [[ZNEvent alloc] init];
            event.name = item[@"name"];
            event.type = [[ZNEventType alloc] init];
            event.type.name = [NSString stringWithFormat:@"%@", item[@"type_id"]];
            event.organization = item[@"organization"];
            event.host = [[ZNUser alloc] init];
            event.host.name = item[@"host"];
            event.description = item[@"description"];
            event.startTime = item[@"start_time"];
            event.endTime = item[@"end_time"];
            event.place.name = [NSString stringWithFormat:@"%@", item[@"place_id"]];
            event.detailedPlace = item[@"address"];
            event.followerCount = [item[@"follower_count"] integerValue];
            [self.eventList addObject:event];
        }
        success(self.eventList);
    } failure:failure];
}

@end