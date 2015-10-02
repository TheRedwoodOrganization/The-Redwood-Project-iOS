//
//  BlogCreationViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 29/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "BlogCreationViewController.h"

@interface BlogCreationViewController ()
@property (strong, nonatomic) IBOutlet UITextField *blogTitle;
@property (strong, nonatomic) IBOutlet UITextField *bannerUrl;

@property (strong,nonatomic) Blog *freshBlog;

@end

@implementation BlogCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)create:(id)sender {
    self.freshBlog = [[Blog alloc]init];
    self.freshBlog.title = self.blogTitle.text;
    self.freshBlog.imageUrl = self.bannerUrl.text;
    User *foundUser = [[User alloc]init];
    foundUser.userName = [self.ownerUser objectForKey:@"username"];
    self.freshBlog.user = foundUser;
    
    [self createBlog];
    
}

- (void)createBlog {
    PFObject *createdBlog = [PFObject objectWithClassName:@"Blog"];
    createdBlog[@"user"] = self.ownerUser;
    createdBlog[@"blogTitle"] = self.freshBlog.title;
    createdBlog[@"image"] = self.freshBlog.imageUrl;

    [createdBlog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFQuery *innerquery = [PFQuery queryWithClassName:@"Blog"];
            [innerquery whereKey:@"blogTitle" equalTo:self.freshBlog.title];
            PFObject *blog = [innerquery getFirstObject];
            PFUser *temp = [PFUser currentUser];
            [temp setObject:[NSNumber numberWithBool:YES] forKey:@"hasBlog"];
            [temp saveInBackground];
            self.freshBlog.parseId = blog.objectId;
        } else {
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"unwindToHomePage" sender:self];
        });
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.description isKindOfClass:[PostTableViewController class]]) {
        PostTableViewController *viewController = segue.destinationViewController;
        viewController.receivedblog = self.freshBlog;
        viewController.title = self.blogTitle.text;
        [viewController.navigationItem setHidesBackButton:YES];
    }
}

@end
