//
//  DriveStatViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveStatViewController.h"
#import "Networker.h"

@interface DriveStatViewController ()
@property (strong, nonatomic) IBOutlet UILabel *driveRank;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIImageView *overallBadge;

@end

@implementation DriveStatViewController

- (void)viewDidLoad
{
    self.activity.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.activity startAnimating];

    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(requestStats)
                                       userInfo:nil
                                        repeats:NO];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];
}

- (void)requestStats
{
    NSDictionary *stats = [Networker endRide];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activity stopAnimating];
        self.activity.hidden = YES;

        self.driveRank.text = [stats objectForKey:@"currentGrade"];
        self.overallBadge.image = [UIImage imageNamed:[self imageNameForBadge:[stats objectForKey:@"overallGrade"]]];
    });
}

- (NSString *)imageNameForBadge:(NSString *)badgeName
{
    if ([badgeName isEqualToString:@"Driving School Teacher"]) {
        return @"badge-green-dark";
    } else if ([badgeName isEqualToString:@"Experienced Driver"]) {
        return @"badge-green-light";
    } else if ([badgeName isEqualToString:@"Amateur"]) {
        return @"badge-yellow";
    } else if ([badgeName isEqualToString:@"Blind granny"]) {
        return @"badge-red-light";
    } else {
        return @"badge-red-dark";
    }
}

- (IBAction)backToOverview:(id)sender {
    [self performSegueWithIdentifier:@"toOverview" sender:self];
}



@end
