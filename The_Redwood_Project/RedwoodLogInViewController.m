//
//  RedwoodLogInViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 22/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "RedwoodLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RedwoodLogInViewController ()

@end

@implementation RedwoodLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"better-background.png"]]];
    
    //UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Redwood-Project-logo.jpg"]];
    UILabel *logoView = [[UILabel alloc]init];
    logoView.text = @"The Redwood Project";
    logoView.textColor = [UIColor redColor];
    logoView.font = [UIFont fontWithName:@"Zapfino" size:24.0f];

    self.logInView.logo = logoView; // logo can be any UIView
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
