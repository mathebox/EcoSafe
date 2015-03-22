//
//  DriveViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveViewController.h"

typedef NS_ENUM(NSUInteger, EventType) {
    EventTypeAcceleration = 0,
    EventTypeBrake,
    EventTypeIdle,
    EventTypeDistance,
    EventTypeTurn,
    EventTypeSpeed,
    EventTypeJam,
    EventTypeSlow,
    EventTypeNone,
};

@interface DriveViewController ()

@property (strong, nonatomic) IBOutlet UIView *alertView1;
@property (strong, nonatomic) IBOutlet UIView *alertView2;
@property (strong, nonatomic) IBOutlet UIView *alertView3;

@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *imageView3;

@property (strong, nonatomic) IBOutlet UILabel *title1;
@property (strong, nonatomic) IBOutlet UILabel *title2;
@property (strong, nonatomic) IBOutlet UILabel *title3;

@property (strong, nonatomic) NSArray *alertViews;
@property (strong, nonatomic) NSArray *imageViews;
@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) NSArray *lastEvents;

@end

@implementation DriveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.lastEvents = @[];
    self.alertViews = @[self.alertView1, self.alertView2, self.alertView3];
    self.imageViews = @[self.imageView1, self.imageView2, self.imageView3];
    self.titles = @[self.title1, self.title2, self.title3];

    [self.alertViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//        UIGraphicsBeginImageContext(view.bounds.size);
//        [[UIImage imageNamed:@"button-bg"] drawInRect:view.bounds];
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        UIColor *color = [UIColor colorWithPatternImage:image];

        view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
    }];

    [self newEvent:[NSNumber numberWithInt:1]];
    [self newEvent:[NSNumber numberWithInt:2]];
    [self newEvent:[NSNumber numberWithInt:3]];
    [self newEvent:[NSNumber numberWithInt:4]];
}

- (IBAction)endDrive:(id)sender {
    // send end Drive
    [self performSegueWithIdentifier:@"showDriveStats" sender:self];
}

- (void)newEvent:(NSNumber *)type
{
    if (self.lastEvents.count == 3) {
        self.lastEvents = @[self.lastEvents[1], self.lastEvents[2], type];
    } else if (self.lastEvents.count == 2) {
        self.lastEvents = @[self.lastEvents[0], self.lastEvents[1], type];
    } else if (self.lastEvents.count == 1) {
        self.lastEvents = @[self.lastEvents[0], type];
    } else {
        self.lastEvents = @[type];
    }

    [self updateViews];
}

- (void)updateViews
{
    for (int i = 0; i < self.lastEvents.count; i++ ) {
        ((UILabel *)self.titles[self.lastEvents.count-i-1]).text = [self titleForEventType:self.lastEvents[i]];
        ((UIImageView *)self.imageViews[self.lastEvents.count-i-1]).image = [UIImage imageNamed:[self imageNameForEventType:self.lastEvents[i]]];
        ((UIView *)self.alertViews[self.lastEvents.count-i-1]).hidden = false;
    }

    for (int i = self.lastEvents.count; i < 3; i++) {
        ((UIView *)self.alertViews[i]).hidden = true;
    }
}

- (NSString *)titleForEventType:(NSNumber *)type
{
    if (type.integerValue == 0) {
        return @"Accelerate";
    } else if (type.integerValue == 1) {
        return @"Brake";
    } else if (type.integerValue == 2) {
        return @"Idle";
    } else if (type.integerValue == 3) {
        return @"Distance";
    } else if (type.integerValue == 4) {
        return @"Turn";
    } else if (type.integerValue == 5) {
        return @"Speed";
    } else if (type.integerValue == 6) {
        return @"Jam";
    } else if (type.integerValue == 7) {
        return @"Brake";
    } else if (type.integerValue == 8) {
        return @"Slow";
    } else {
        return @"";
    }
}

- (NSString *)imageNameForEventType:(NSNumber *)type
{
    if (type.integerValue == 0) {
        return @"steer.png";
    } else if (type.integerValue == 1) {
        return @"steer.png";
    } else if (type.integerValue == 2) {
        return @"steer.png";
    } else if (type.integerValue == 3) {
        return @"steer.png";
    } else if (type.integerValue == 4) {
        return @"steer.png";
    } else if (type.integerValue == 5) {
        return @"steer.png";
    } else if (type.integerValue == 6) {
        return @"steer.png";
    } else if (type.integerValue == 7) {
        return @"steer.png";
    } else if (type.integerValue == 8) {
        return @"steer.png";
    } else {
        return @"";
    }
}

@end
