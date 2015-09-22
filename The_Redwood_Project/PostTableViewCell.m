//
//  PostTableViewCell.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostTableViewCell.h"

@interface PostTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *doc;

@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createCells:(Post *)post{
    
    self.title.text = post.title;
    self.doc.text = [NSString stringWithFormat:@"%@", post.doc];
    
}

@end
