//
//  ZNEventList.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNetwork.h"

NSString * const baseURL = @"http://localhost";
NSString * const eventListURL = @"/ZheNar/event/test.json?1";
NSString * const placeListURL = @"/ZheNar/place/test.json?1";

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

/* add searched object to dictionary or not? */
- (void)requestPlaceWithID:(NSString *)placeID success:(void (^)(ZNPlace *))success failure:(void (^)(NSError *))failure
{
    ZNPlace *place;
    if (self.placeDictionary) {
        place = self.placeDictionary[placeID];
        if (place) {
            success(place);
        }
        else {
            place = [[ZNPlace alloc] init];
            [self requestJSONWithPath:placeListURL success:^(id JSON) {
                id item = JSON[placeID];
                place.name = item[@"name"];
                //place.position = CGPointMake(item[@"longtitude"], item[@"latitude"]);
                place.type = item[@"type"];
                place.description = item[@"description"];
                [self.placeDictionary setObject:place forKey:placeID];
                success(place);
            } failure:failure];
        }
    }
    else {
        place = [[ZNPlace alloc] init];
        [self requestJSONWithPath:placeListURL success:^(id JSON) {
            id item = JSON[placeID];
            place.name = item[@"name"];
            //place.position = CGPointMake(item[@"longtitude"], item[@"latitude"]);
            place.type = item[@"type"];
            place.description = item[@"description"];
            self.placeDictionary = [[NSMutableDictionary alloc] init];
            [self.placeDictionary setObject:place forKey:placeID];
            success(place);
        } failure:failure];
    }
}

- (NSDate *)dateWithJSONString:(NSString *)JSONDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm'Z'"];
    NSDate *date = [dateFormatter dateFromString:JSONDate];
    return date;
}

- (void)requestEventListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;
{
    [self requestJSONWithPath:eventListURL success:^(id JSON) {
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
            [self requestPlaceWithID:[item[@"place_id"] description] success:^(ZNPlace *requestedPlace) {
                event.place = requestedPlace;
            } failure:failure];
            event.detailedPlace = item[@"address"];
            
            event.followerCount = [item[@"follower_count"] integerValue];
            [self.eventList addObject:event];
        }
        success(self.eventList);
    } failure:failure];
}

- (void)requestPlaceListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    [self requestJSONWithPath:placeListURL success:^(id JSON) {
        self.placeList = [[NSMutableArray alloc] init];
        NSArray *keys = [JSON allKeys];
        for (NSString *key in keys) {
            id item = JSON[key];
            ZNPlace *place = [[ZNPlace alloc] init];
            place.name = item[@"name"];
            place.type = [[ZNPlaceType alloc] init];
            place.type.name = [item[@"type"] description];
            //place.position = CGPointMake(item[@"longtitude"], item[@"latitude"]);
            [self.placeList addObject:place];
            [self.placeDictionary setObject:place forKey:key];
        }
        success(self.placeList);
    } failure:failure];
}

@end