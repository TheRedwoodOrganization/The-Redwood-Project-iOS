//
//  BlogTableViewCell.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 22/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "BlogTableViewCell.h"

@interface BlogTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *by;


@end

@implementation BlogTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createCells:(Blog *)blog{
    self.title.text = blog.title;
    self.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:blog.imageUrl]]];
    self.by.text = [NSString stringWithFormat:@"By: %@", blog.user.userName];
    
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.image.image = nil;
    self.title.text = @"";
    self.by.text = @"";
}

@end
