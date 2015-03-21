//
//  OverviewViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "OverviewViewController.h"

@interface OverviewViewController ()
@property (strong, nonatomic) IBOutlet UIButton *carIcon;
@property (strong, nonatomic) IBOutlet UIButton *statIcon;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIImageView *iamge;

@end

@implementation OverviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.iamge.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.carIcon.alpha = 0.0;
    self.statIcon.alpha = 0.0;
    self.logoutButton.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self showIcons];
    
}

- (void)showIcons
{
    [UIView animateWithDuration:0.5
                          delay:0.25
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.carIcon.alpha = 1.0;
                         self.statIcon.alpha = 1.0;
                     } completion:^(BOOL finished) {
                        [self showLogoutButton];
                     }
     ];
}

- (void)showLogoutButton
{
    [UIView animateWithDuration:0.5
                          delay:0.25
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.logoutButton.alpha = 1.0;
                     } completion:NULL
     ];
}

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
