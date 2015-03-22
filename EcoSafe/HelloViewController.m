//
//  HelloViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "HelloViewController.h"

@interface HelloViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *bg;


@end

@implementation HelloViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.bg.contentMode =UIViewContentModeScaleAspectFill;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showImage];
}

- (void)showImage
{
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.image.alpha = 1.0; }
                     completion:^(BOOL finished) { [self showLabel];}
     ];
}

- (void)showLabel
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ self.label.alpha = 1.0; }
                     completion:^(BOOL finished) { [self toNextView];}
     ];
}

- (void)toNextView
{
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.image.alpha = 0.0;
                         self.label.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [self performSegueWithIdentifier:@"next" sender:self];
                         });

                     }
     ];
}

@end
