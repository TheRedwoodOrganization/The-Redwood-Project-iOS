//
//  PostDetailViewController.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 23/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Comment.h"
#import "Post.h"
#import "CommentHeaderTableViewCell.h"

@interface PostDetailViewController : UIViewController <CommentReadiness>

@property (strong, nonatomic) NSMutableArray *commentArray;
@property (strong, nonatomic) Post *receivedPost;
@property (strong, nonatomic) PFUser *currentUser;

@end
