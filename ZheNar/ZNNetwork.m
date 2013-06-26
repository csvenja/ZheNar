//
//  ZNEventList.m
//  ZheNar
//
//  Created by C.Svenja on 2013-06-18.
//  Copyright (c) 2013 Zhenar. All rights reserved.
//

#import "ZNNetwork.h"
#import "ISO8601DateFormatter.h"

NSString * const kBaseURL = @"http://10.71.10.71:8000/";
NSString * const kEventListURL = @"/api/event/";
NSString * const kPlaceListURL = @"/api/place/";
NSString * const kUserURL = @"/api/user/login/email/";
NSString * const kUserRegURL = @"/api/user/reg/";

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
        self.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        [self.httpClient setParameterEncoding:AFFormURLParameterEncoding];
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

- (void)requestPlaceWithID:(NSString *)placeID success:(void (^)(ZNPlace *))success failure:(void (^)(NSError *))failure
{
    ZNPlace *place;
    
    place = self.placeDictionary[placeID];
    if (place) {
        success(place);
    }
    else {
        place = [[ZNPlace alloc] init];
        [self requestJSONWithPath:kPlaceListURL success:^(id JSON) {
            id item = JSON[placeID];
            place.title = item[@"name"];
            place.coordinate = CLLocationCoordinate2DMake([item[@"latitude"] doubleValue], [item[@"longitude"] doubleValue]);
            place.type = item[@"type"];
            place.subtitle = item[@"description"];
            [self.placeDictionary setObject:place forKey:placeID];
            success(place);
        } failure:failure];
    }
}

- (void)requestEventListWithSuccess:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure;
{
    [self requestJSONWithPath:kEventListURL success:^(id JSON) {
        self.eventList = [[NSMutableArray alloc] init];
        for (id item in JSON) {
            ZNEvent *event = [[ZNEvent alloc] init];
            event.name = item[@"name"];
            event.type = [[ZNEventType alloc] init];
            event.type.name = item[@"type"];
            event.organization = item[@"organization"];
            event.host = [[ZNUser alloc] init];
            event.host.username = item[@"host"];
            event.description = item[@"description"];
            
            ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
            event.startTime = [formatter dateFromString:item[@"start_time"]];
            event.endTime = [formatter dateFromString:item[@"end_time"]];
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
    [self requestJSONWithPath:kPlaceListURL success:^(id JSON) {
        self.placeList = [[NSMutableArray alloc] init];
        NSArray *keys = [JSON allKeys];
        for (NSString *key in keys) {
            id item = JSON[key];
            ZNPlace *place = [[ZNPlace alloc] init];
            place.title = item[@"name"];
            place.subtitle = item[@"description"];
            place.type = [[ZNPlaceType alloc] init];
            place.type.name = [item[@"type"] description];
            place.coordinate = CLLocationCoordinate2DMake([item[@"latitude"] doubleValue], [item[@"longitude"] doubleValue]);
            [self.placeList addObject:place];
            [self.placeDictionary setObject:place forKey:key];
        }
        success(self.placeList);
    } failure:failure];
}

- (void)requestUserWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure
{
    NSMutableURLRequest *request = [self.httpClient requestWithMethod:@"POST" path:kUserURL parameters:@{@"email":email, @"password":password}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        [user setDictionary:JSON];
        if (user[@"student_name"] == [NSNull null]) {
            user[@"student_name"] = [[NSString alloc] init];
        }
        success(user);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed to get JSON: %@", [error userInfo]);
        if (JSON[@"error"]) {
            failure(JSON[@"error"]);
        }
        else {
            failure(@"Network error.");
        }
    }];
    [operation start];
}

- (void)registerWithEmail:(NSString *)email username:(NSString *)username password:(NSString *)password studentName:(NSString *)studentName success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure
{
    NSMutableURLRequest *request = [self.httpClient requestWithMethod:@"POST" path:kUserRegURL parameters:@{@"email":email, @"username":username, @"password":password, @"student_name":studentName}];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        [user setDictionary:JSON];
        if (user[@"student_name"] == nil) {
            [user[@"student_name"] string];
        }
        success(user);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failed to get JSON: %@", [error userInfo]);
        if (JSON[@"error"]) {
            failure(JSON[@"error"]);
        }
        else {
            failure(@"Network error.");
        }
    }];
    [operation start];
}

@end