//
//  CommentHeaderTableViewCell.h
//  The_Redwood_Project
//
//  Created by Jean Smits on 25/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentReadiness

- (void) commentIsReady: (NSString *)commentContent;

@end

@interface CommentHeaderTableViewCell : UITableViewCell

@property (assign, nonatomic) id<CommentReadiness> delegate;

-(void)checkingString;

@end
