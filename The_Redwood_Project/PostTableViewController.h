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
#import "ParseManager.h"

@interface PostTableViewController : UITableViewController <parseHasFinished>

@property (strong, nonatomic) Post *thisPost;
@property (strong, nonatomic) NSMutableArray *postArray;

@end
