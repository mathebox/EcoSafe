//
//  DriveViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveViewController.h"

@interface DriveViewController ()

@end

@implementation DriveViewController

- (IBAction)endDrive:(id)sender {
    // send end Drive
    [self performSegueWithIdentifier:@"showDriveStats" sender:self];
}

@end
