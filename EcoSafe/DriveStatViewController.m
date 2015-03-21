//
//  DriveStatViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveStatViewController.h"

@interface DriveStatViewController ()

@end

@implementation DriveStatViewController

- (IBAction)backToOverview:(id)sender {
    [self performSegueWithIdentifier:@"toOverview" sender:self];
}



@end
