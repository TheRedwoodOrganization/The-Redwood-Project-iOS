//
//  Post.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import "BlogPoster.h"

@interface Post : NSObject


@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *doc;


@property (strong, nonatomic) BlogPoster *blogger;
@property (strong, nonatomic) NSMutableArray *commentArray;

@end
