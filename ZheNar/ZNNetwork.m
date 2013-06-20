//
//  ZNEventList.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNetwork.h"

NSString * const baseURL = @"http://localhost";

@implementation ZNNetwork

+ (ZNNetwork *)me
{
    static ZNNetwork *theOnly = nil;
    
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

- (void)requestPlaceWithID:(NSInteger)placeID withSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    if (self.placeDictionary == nil) {
        [self requestJSONWithPath:@"/ZheNar/place/test.json" success:^(id JSON) {
            NSString *placeIDKey = [NSString stringWithFormat:@"%d", placeID];
            success(JSON[placeIDKey]);
        } failure:failure];
    }
    else {
        
    }
}

- (NSDate *)dateWithJSONString:(NSString*)JSONDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"];
    NSDate *date = [dateFormatter dateFromString:JSONDate];
    return date;
}

- (void)requestEventListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;
{
    [self requestJSONWithPath:@"/ZheNar/event/test.json?miao" success:^(id JSON) {
        self.eventList = [[NSMutableArray alloc] init];
        for (id item in JSON) {
            ZNEvent *event = [[ZNEvent alloc] init];
            event.name = item[@"name"];
            event.type = [[ZNEventType alloc] init];
            event.type.name = item[@"type"];
            event.organization = item[@"organization"];
            event.host = [[ZNUser alloc] init];
            event.host.name = item[@"host"];
            event.description = item[@"description"];
            
            event.startTime = [self dateWithJSONString:item[@"start_time"]];
            event.endTime = [self dateWithJSONString:item[@"end_time"]];
            event.place = [[ZNPlace alloc] init];
            event.place.name = [item[@"place_id"] description];
            event.detailedPlace = item[@"address"];
            
            event.followerCount = [item[@"follower_count"] integerValue];
            [self.eventList addObject:event];
        }
        success(self.eventList);
    } failure:failure];
}

- (void)requestPlaceListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    /*[self requestJSONWithPath:@"/ZheNar/place/test.json" success:^(id JSON) {
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
    } failure:failure];*/
}

@end