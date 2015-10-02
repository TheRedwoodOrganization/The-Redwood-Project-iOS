//
//  UserDetailViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 28/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "UserDetailViewController.h"
#import "HomePageViewController.h"

@interface UserDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UIButton *blogLink;

@property (strong, nonatomic) Blog *ownerBlog;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUp{
    
    self.userName.text = [self.currentUser objectForKey:@"username"];
    self.email.text = [self.currentUser objectForKey:@"email"];
    self.profileImg.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.currentUser objectForKey:@"profilePic"]]]];
    [self.email setLineBreakMode:NSLineBreakByWordWrapping];
    self.email.numberOfLines = 0;
    [self.email sizeToFit];
    
    self.ownerBlog = [self findOwnerBlog];
}

- (IBAction)goToBlog:(id)sender {
    
    if ([[self.currentUser objectForKey:@"hasBlog" ] boolValue]) {
        [self performSegueWithIdentifier:@"unwindToHomePage" sender:self];
    } else {
        [self performSegueWithIdentifier:@"Create Blog" sender:self];
    }
    
}


- (Blog *) findOwnerBlog{
    PFQuery *blogQuery = [PFQuery queryWithClassName:@"Blog"];
    [blogQuery whereKey:@"user" equalTo:self.currentUser];
    
    PFObject *ownerBlog = [blogQuery getFirstObject];
    Blog *blog = [[Blog alloc]init];
    blog.title = [ownerBlog objectForKey:@"blogTitle"];
    blog.parseId = ownerBlog.objectId;
    blog.imageUrl = [ownerBlog objectForKey:@"image"];
    
    NSString *userId = [ownerBlog[@"user"]objectId];
    PFUser *user = [PFQuery getUserObjectWithId:userId];
    User *foundUser = [[User alloc]init];
    foundUser.userName = [user objectForKey:@"username"];
    blog.user = foundUser;
    return blog;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"unwindToHomePage"]) {
        HomePageViewController *viewController = segue.destinationViewController;
        viewController.ownerBlog = self.ownerBlog;
        
    } else {
        UINavigationController *navController = segue.destinationViewController;
        BlogCreationViewController *viewController = (BlogCreationViewController *)navController.topViewController;
        viewController.ownerUser = self.currentUser;
    }
    
}



@end
