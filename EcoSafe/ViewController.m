//
//  ViewController.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *centerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.centerView.alpha = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.centerView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self performSegueWithIdentifier:@"login" sender:self];
                     }
     ];

}

- (IBAction)unwindLogin:(UIStoryboardSegue *)unwindSegue
{
    // do nothing
}


@end
