//
//  RedwoodSignUpViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 02/10/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "RedwoodSignUpViewController.h"

@implementation RedwoodSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"better-background.png"]]];
    
    //UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Redwood-Project-logo.jpg"]];
    UILabel *logoView = [[UILabel alloc]init];
    logoView.text = @"The Redwood Project";
    logoView.textColor = [UIColor redColor];
    logoView.font = [UIFont fontWithName:@"Zapfino" size:24.0f];
    
    self.signUpView.logo = logoView; // logo can be any UIView
}

@end
