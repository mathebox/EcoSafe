//
//  OverviewViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "OverviewViewController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (IBAction)tabBar:(id)sender {
    [self performSegueWithIdentifier:@"showStatistic" sender:self];
}

- (IBAction)tapSteer:(id)sender {
    [self performSegueWithIdentifier:@"showLiveView" sender:self];
}

- (IBAction)logut:(id)sender {
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (IBAction)unwindToOverview:(UIStoryboardSegue *)unwindSegue
{
    // do nothing
}


@end
