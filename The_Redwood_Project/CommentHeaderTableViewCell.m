//
//  CommentHeaderTableViewCell.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 25/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "CommentHeaderTableViewCell.h"
@interface CommentHeaderTableViewCell()

@property (weak, nonatomic) IBOutlet UITextView *freshComment;


@end

@implementation CommentHeaderTableViewCell

@synthesize delegate;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addComment:(id)sender {
    
    [self checkingString];
    self.freshComment.text = @"";
    
}

- (void)checkingString{
    NSString *test = self.freshComment.text;
    if (![test  isEqual: @""]) {
        [self.delegate commentIsReady:test];
    }
}

@end
