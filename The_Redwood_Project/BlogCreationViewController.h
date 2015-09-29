//
//  BlogCreationViewController.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 29/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PostTableViewController.h"
#import "Blog.h"
#import "User.h"

@interface BlogCreationViewController : UIViewController

@property (strong, nonatomic) PFUser *ownerUser;

@end
