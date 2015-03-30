//
//  DriveStatViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveStatViewController.h"
#import "Networker.h"
#import "AlternativesViewController.h"

@interface DriveStatViewController ()
@property (strong, nonatomic) IBOutlet UILabel *driveRank;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIImageView *overallBadge;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) NSArray *alternatives;

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

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.0
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

        self.scoreLabel.text = @"Score";
        self.driveRank.text = [stats objectForKey:@"currentGrade"];
        self.overallBadge.image = [UIImage imageNamed:[self imageNameForBadge:[stats objectForKey:@"overallGrade"]]];
        self.alternatives = [stats objectForKey:@"allRyderCompare"];
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

- (IBAction)showAlternatives:(id)sender {
    [self performSegueWithIdentifier:@"alternatives" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"alternatives"]) {
        AlternativesViewController *avc = (AlternativesViewController *)segue.destinationViewController;
        avc.alternatives = self.alternatives;
    }
}

- (IBAction)tweet:(id)sender {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.0
                                             target:self
                                           selector:@selector(_tweet)
                                           userInfo:nil
                                            repeats:NO];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];

}

- (void)_tweet
{
    [Networker tweet];
}

@end
