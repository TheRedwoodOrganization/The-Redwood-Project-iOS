//
//  PostCreationViewController.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 25/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Blog.h"

@interface PostCreationViewController : UIViewController

@property (strong, nonatomic) PFUser *creatorUser;
@property (strong, nonatomic) Blog *currentBlog;

@end
