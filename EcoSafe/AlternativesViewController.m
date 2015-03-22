//
//  AlternativesViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 22/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "AlternativesViewController.h"

@interface AlternativesViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UILabel *company1;
@property (strong, nonatomic) IBOutlet UILabel *time1;
@property (strong, nonatomic) IBOutlet UILabel *price1;

@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UILabel *company2;
@property (strong, nonatomic) IBOutlet UILabel *time2;
@property (strong, nonatomic) IBOutlet UILabel *price2;

@property (strong, nonatomic) IBOutlet UIImageView *image3;
@property (strong, nonatomic) IBOutlet UILabel *company3;
@property (strong, nonatomic) IBOutlet UILabel *title3;
@property (strong, nonatomic) IBOutlet UILabel *price3;

@property (strong, nonatomic) IBOutlet UIImageView *image4;
@property (strong, nonatomic) IBOutlet UILabel *company4;
@property (strong, nonatomic) IBOutlet UILabel *title4;
@property (strong, nonatomic) IBOutlet UILabel *price4;

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *companies;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *prices;

@end

@implementation AlternativesViewController

- (void)viewDidLoad
{
    self.images = @[self.image1, self.image2, self.image3, self.image4];
    self.companies = @[self.company1, self.company2, self.company3, self.company4];
    self.titles = @[self.time1, self.time2, self.title3, self.title4];
    self.prices = @[self.price1, self.price2, self.price3, self.price4];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateContent];
}


- (IBAction)toOverview:(id)sender {
    [self performSegueWithIdentifier:@"toOverview" sender:self];
}

- (void)updateContent
{
    for (int i = 0; i < self.alternatives.count; i++) {
        NSArray *alternative = self.alternatives[i];

        ((UIImageView *)self.images[i]).image = [UIImage imageNamed:[self imageName:alternative[0]]];
        ((UILabel *)self.companies[i]).text = alternative[1];
        ((UILabel *)self.titles[i]).text = alternative[2];
        ((UILabel *)self.prices[i]).text = alternative[3];
    }
}

- (NSString *)imageName:(NSString *)name
{
    if ([name isEqualToString:@"public_transport"]) {
        return @"bus";
    } else if ([name isEqualToString:@"car_sharing"]) {
        return @"car-sharing";
    } else if ([name isEqualToString:@"bike_sharing"]) {
        return @"bike";
    } else if ([name isEqualToString:@"taxi"]) {
        return @"taxi";
    } else {
        return @"";
    }
}

@end
