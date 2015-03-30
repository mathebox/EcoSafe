//
//  DriveViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "DriveViewController.h"
#import "Networker.h"

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

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UIImageView *additionalView;

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
        NSLog(@"frame %f %f %f %f" , view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        NSLog(@"bounds %f %f %f %f" , view.bounds.origin.x, view.bounds.origin.y, view.bounds.size.width, view.bounds.size.height);
        CGRect b = CGRectMake(0, 0, view.bounds.size.width*0.94, view.bounds.size.height*0.48);
        UIGraphicsBeginImageContext(view.frame.size);
        [[[UIImage imageNamed:@"button-bg-2"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)] drawInRect:b];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIColor *color = [UIColor colorWithPatternImage:image];
        view.backgroundColor = color;
//        view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
        view.hidden = YES;
    }];

    [Networker startRide];

    self.timer = [NSTimer timerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(updateEvents)
                                       userInfo:nil
                                        repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self.timer forMode: NSDefaultRunLoopMode];
}

- (void)updateEvents
{
    NSArray *updates = [Networker eventUpdate];
//    NSLog(@"%@, %@", updates, [updates[0] class]);

    int additonal = 0;

    for (int i = 0; i < updates.count; i++) {
        NSNumber *update = updates[i];
        if (update.boolValue) {
            NSLog(@"YES %d", i);
            if (i == 2 || i == 6 || i == 7) {
                additonal = MAX(additonal, i);
            } else {
            [self newEvent:[NSNumber numberWithInt:i]];
            }
        }
    }

    if (additonal == 0) {
        self.additionalView.hidden = YES;
    } else {
        self.additionalView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
        self.additionalView.image = [UIImage imageNamed:[self imageNameForEventType:[NSNumber numberWithInt:additonal]]];
        self.additionalView.hidden = FALSE;

    }
}

- (IBAction)endDrive:(id)sender {
    [self.timer invalidate];
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

    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateViews];
    });

}

- (void)updateViews
{
    for (int i = 0; i < self.lastEvents.count; i++ ) {
        ((UILabel *)self.titles[self.lastEvents.count-i-1]).text = [self titleForEventType:self.lastEvents[i]];
        ((UIImageView *)self.imageViews[self.lastEvents.count-i-1]).image = [UIImage imageNamed:[self imageNameForEventType:self.lastEvents[i]]];
        ((UIView *)self.alertViews[self.lastEvents.count-i-1]).hidden = NO;
    }

    for (int i = self.lastEvents.count; i < 3; i++) {
        ((UIView *)self.alertViews[i]).hidden = YES;
    }
}

- (NSString *)titleForEventType:(NSNumber *)type
{
    if (type.integerValue == 0) {
        return @"Rough acceleration";
    } else if (type.integerValue == 1) {
        return @"Rough brake";
    } else if (type.integerValue == 2) {
        return @"Motor on while parking";
    } else if (type.integerValue == 3) {
        return @"Too close to next driver";
    } else if (type.integerValue == 4) {
        return @"Rough turn";
    } else if (type.integerValue == 5) {
        return @"Exceeding the speed limit";
    } else if (type.integerValue == 6) {
        return @"Stuck in traffic jam";
    } else if (type.integerValue == 7) {
        return @"Too slow driving speed";
    } else {
        return @"";
    }
}

- (NSString *)imageNameForEventType:(NSNumber *)type
{
    if (type.integerValue == 0) {
        return @"event-accelerate";
    } else if (type.integerValue == 1) {
        return @"event-brake";
    } else if (type.integerValue == 2) {
        return @"event-idle";
    } else if (type.integerValue == 3) {
        return @"event-distance";
    } else if (type.integerValue == 4) {
        return @"event-turn";
    } else if (type.integerValue == 5) {
        return @"event-fast";
    } else if (type.integerValue == 6) {
        return @"event-jam";
    } else if (type.integerValue == 7) {
        return @"event-slow";
    } else {
        return @"";
    }
}

@end
