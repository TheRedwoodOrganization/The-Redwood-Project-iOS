//
//  PostHeaderTableViewCell.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 23/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostHeaderTableViewCell.h"

@interface PostHeaderTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@end

@implementation PostHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createCells:(Blog *)currentBlog{
    self.headerImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentBlog.imageUrl]]];
}

@end
