//
//  UserManager.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 02/10/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

@interface UserManager : NSObject

@property (nonatomic, strong) PFUser *currentUser;

+ (UserManager *)sharedInstance;
- (void)refetchCurrentUser;

@end
