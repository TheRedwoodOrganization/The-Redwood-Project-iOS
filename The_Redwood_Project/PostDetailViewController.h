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

@interface PostDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *commentArray;
@property (strong, nonatomic) Post *receivedPost;

@end
