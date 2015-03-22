//
//  Networker.m
//  EcoSafe
//
//  Created by Max Bothe on 22/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "Networker.h"

NSString *host = @"http://169.254.85.33:5000/%@";

@implementation Networker

+ (NSData *)dataFromUrl:(NSString *)url
{
    return [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
}

+ (void)startRide
{
    [self dataFromUrl:[NSString stringWithFormat:host, @"startRide"]];
}

+ (void)endRide
{
    [self dataFromUrl:[NSString stringWithFormat:host, @"endRide"]];
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

@end
