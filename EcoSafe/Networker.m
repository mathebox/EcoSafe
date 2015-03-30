//
//  Networker.m
//  EcoSafe
//
//  Created by Max Bothe on 22/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "Networker.h"

NSString *host = @"http://192.168.0.18:5000/%@";

@implementation Networker

+ (NSData *)dataFromUrl:(NSString *)url
{
    return [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
}

+ (void)startRide
{
    [self dataFromUrl:[NSString stringWithFormat:host, @"ride/start"]];
}

+ (NSDictionary *)endRide
{
    NSData *data = [self dataFromUrl:[NSString stringWithFormat:host, @"ride/end"]];

    NSError* error;
    NSDictionary *stats = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:&error];
    return stats;
}

+ (NSArray *)eventUpdate
{
    NSData *data = [self dataFromUrl:[NSString stringWithFormat:host, @"events"]];

    NSError* error;
    NSArray *updates = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:&error];
    return updates;
}

+ (void)tweet
{
    [self dataFromUrl:[NSString stringWithFormat:host, @"tweet"]];
}

@end
