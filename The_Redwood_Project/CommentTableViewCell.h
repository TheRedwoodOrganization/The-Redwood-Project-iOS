//
//  CommentTableViewCell.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "User.h"

@interface CommentTableViewCell : UITableViewCell

- (void) createCells:(Comment *)comment;

@end
