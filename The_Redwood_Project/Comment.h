//
//  Comment.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject

@property (weak, nonatomic) User *user;
@property (strong, nonatomic) NSString *doc;
@property (strong, nonatomic) NSString *content;

@end
