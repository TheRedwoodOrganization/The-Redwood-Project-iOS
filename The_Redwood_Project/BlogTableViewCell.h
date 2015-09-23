//
//  BlogTableViewCell.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 22/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"

@interface BlogTableViewCell : UITableViewCell

- (void) createCells:(Blog *)blog;

@end
