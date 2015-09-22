//
//  ParseManager.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 22/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "ParseManager.h"

@interface ParseManager ()



@end

@implementation ParseManager

- (void) getAllPosts{
    self.foundPostArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            for (PFObject *pfObject in objects) {
                Post *post = [[Post alloc]init];
                post.title = [pfObject objectForKey:@"postTitle"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyy-MM-dd"];
                post.doc = [df stringFromDate:pfObject.createdAt];
                [self.foundPostArray addObject:post];
            };
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate postArrayIsReady:self.foundPostArray];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
