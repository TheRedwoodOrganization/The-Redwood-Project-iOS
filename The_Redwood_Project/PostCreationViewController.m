//
//  PostCreationViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 25/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostCreationViewController.h"

@interface PostCreationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITextField *postTitle;

@end

@implementation PostCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PFObject *createdPost = [PFObject objectWithClassName:@"BlogPost"];
    createdPost[@"postBody"] = self.content.text;
    createdPost[@"postTitle"] = self.postTitle.text;
    createdPost[@"user"] = self.creatorUser;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Blog"];
    [innerquery whereKey:@"objectId" equalTo:self.currentBlog.parseId];
    PFObject *blog = [innerquery getFirstObject];
    createdPost[@"blog"] = blog;
    [createdPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
}

@end
