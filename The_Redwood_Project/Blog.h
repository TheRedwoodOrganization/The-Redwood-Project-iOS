//
//  Blog.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Blog : NSObject

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *parseId;
@property (strong, nonatomic) NSString *imageUrl;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@end
