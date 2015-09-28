//
//  PostTableViewController.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"
#import "PostTableViewCell.h"
#import "Blog.h"
#import "PostHeaderTableViewCell.h"
#import "PostCreationViewController.h"

@interface PostTableViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *postArray;
@property (strong, nonatomic) Blog *receivedblog;

@end
