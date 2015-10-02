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

@class CommentTableViewCell;

@protocol CommentTableViewCellDelegate

- (void)didDeleteCommentWithCell:(CommentTableViewCell *)cell;

@end

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CommentTableViewCellDelegate> delegate;
- (void) createCells:(Comment *)comment;

@end
