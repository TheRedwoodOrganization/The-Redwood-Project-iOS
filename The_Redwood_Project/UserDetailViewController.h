//
//  UserDetailViewController.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 28/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PostTableViewController.h"
#import "BlogCreationViewController.h"
#import "Blog.h"

@interface UserDetailViewController : UIViewController

@property (strong , nonatomic) PFUser *currentUser;

@end
