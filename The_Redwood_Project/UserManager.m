//
//  UserManager.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 02/10/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (UserManager *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    static UserManager *uniqueInstance = nil;
    dispatch_once(&predicate, ^{
        uniqueInstance = [UserManager new];
        [uniqueInstance refetchCurrentUser];
    });
    
    return uniqueInstance;
}

- (PFUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [PFUser currentUser];
    }
    
    return _currentUser;
}

- (void)refetchCurrentUser
{
    self.currentUser = [PFUser currentUser];
}

@end
