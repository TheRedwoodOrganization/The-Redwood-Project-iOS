//
//  HomePageViewController.h
//  The_Redwood_Project:
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PostTableViewController.h"
#import "UserLogInViewController.h"
#import "UserDetailViewController.h"
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "Blog.h"


@interface HomePageViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) Blog *ownerBlog;

@end
