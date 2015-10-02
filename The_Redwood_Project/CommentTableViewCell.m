//
//  CommentTableViewCell.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UserManager.h"

@interface CommentTableViewCell()

@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *byAndWin;
@property (weak, nonatomic) IBOutlet UIButton *delete;
@property (weak, nonatomic) NSString *commentId;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleteButtonClicked:(id)sender {
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Comment"];
    [innerquery whereKey:@"objectId" equalTo:self.commentId];
    PFObject *comment = [innerquery getFirstObject];
    [comment deleteInBackgroundWithTarget:self selector:@selector(deleteCallback)];
}

- (void)deleteCallback
{
    [self.delegate didDeleteCommentWithCell:self];
}

-(void)createCells:(Comment *)comment{
    self.content.text = comment.content;
    self.byAndWin.text = [NSString stringWithFormat:@"By %@ at %@", comment.user.userName, comment.doc];
    self.commentId = comment.commentId;
    if ([[UserManager sharedInstance] currentUser] != comment.pfUser){
        [self.delete setEnabled:NO];
        [self.delete setHidden:YES];
    } else {
        [self.delete setHidden:NO];
        [self.delete setEnabled:YES];
    }
}

@end
