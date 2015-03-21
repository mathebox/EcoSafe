//
//  StatisticViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "StatisticViewController.h"

@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (IBAction)toOverview:(id)sender {
    [self performSegueWithIdentifier:@"toOverview" sender:self];
}


@end
