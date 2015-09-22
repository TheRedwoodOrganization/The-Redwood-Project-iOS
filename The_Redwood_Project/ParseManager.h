//
//  ParseManager.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 22/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Post.h"


@protocol parseHasFinished

@optional
- (void) postArrayIsReady: (NSMutableArray *)postArray;
- (void) reviewsForBookArrayIsReady: (NSMutableArray *)reviewsForBookArray;
- (void) bookIsDeleted;
- (void) reviewIsDeleted;

@end

@interface ParseManager : NSObject

@property (weak, nonatomic) id<parseHasFinished> delegate;
@property (strong, nonatomic) NSMutableArray *foundPostArray;

-(void) getAllPosts;




@end