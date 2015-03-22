//
//  Networker.h
//  EcoSafe
//
//  Created by Max Bothe on 22/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networker : NSObject

+ (void)startRide;
+ (void)endRide;

+ (NSArray *)eventUpdate;

@end
