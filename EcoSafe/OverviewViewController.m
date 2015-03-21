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

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBar:)];
//    tap.numberOfTapsRequired = 1;
//    self.barIcon.userInteractionEnabled = YES;
//    [self.barIcon addGestureRecognizer:tap];
//
//    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSteer:)];
//    tap.numberOfTapsRequired = 1;
//    self.steerIcon.userInteractionEnabled = YES;
//    [self.steerIcon addGestureRecognizer:tap];
//}
- (IBAction)tabBar:(id)sender {
    [self performSegueWithIdentifier:@"showStatistic" sender:self];
}

- (IBAction)tapSteer:(id)sender {
    [self performSegueWithIdentifier:@"showLiveView" sender:self];
}

- (IBAction)logut:(id)sender {
    [self performSegueWithIdentifier:@"logout" sender:self];
}


@end
