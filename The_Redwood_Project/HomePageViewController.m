//
//  HomePageViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "HomePageViewController.h"
#import "RedwoodLogInViewController.h"
#import "RedwoodSignUpViewController.h"
#import "Blog.h"
#import "BlogTableViewCell.h"
#import "UserManager.h"

@interface HomePageViewController ()

@property (strong, nonatomic) NSMutableArray *blogArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![[UserManager sharedInstance] currentUser]) { // No user logged in
        [self presentLogInScreen];
    }
    
    [self fillArray];
}

- (IBAction)logOut:(id)sender {
    [[UserManager sharedInstance] setCurrentUser:nil];
    [PFUser logOut];
    [self presentLogInScreen];
}

-(void)fillArray{
    self.blogArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Blog"];
    [query includeKey:@"user"];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            for (PFObject *pfObject in objects) {
                Blog *blog = [[Blog alloc]init];
                blog.title = [pfObject objectForKey:@"blogTitle"];
                blog.parseId = pfObject.objectId;
                blog.imageUrl = [pfObject objectForKey:@"image"];
                
                NSString *userId = [pfObject[@"user"]objectId];
                PFUser *user = [PFQuery getUserObjectWithId:userId];
                User *foundUser = [[User alloc]init];
                foundUser.userName = [user objectForKey:@"username"];
                blog.user = foundUser;
                [self.blogArray addObject:blog];
                
            };
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.blogArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Blog" forIndexPath:indexPath];
    if (self.blogArray.count != 0){
        Blog *blog = self.blogArray[indexPath.row];
        [cell createCells:blog];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Posts" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"UserDetail"]){
        UserDetailViewController *viewController = segue.destinationViewController;
        viewController.currentUser = [[UserManager sharedInstance] currentUser];
        viewController.title = @"Your Account";
    } else if ([segue.identifier isEqualToString:@"Posts"]){
        if (self.ownerBlog == nil) {
            PostTableViewController *viewController = segue.destinationViewController;
            viewController.receivedblog = self.blogArray[self.tableView.indexPathForSelectedRow.row];
            viewController.title = [self.blogArray[self.tableView.indexPathForSelectedRow.row]title];
        } else {
            PostTableViewController *viewController = segue.destinationViewController;
            viewController.receivedblog = self.ownerBlog;
            viewController.title = self.ownerBlog.title;
            self.ownerBlog = nil;
        }
        
    }
}



- (void) presentLogInScreen{
    // Create the log in view controller
    RedwoodLogInViewController *logInViewController = [[RedwoodLogInViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    RedwoodSignUpViewController *signUpViewController = [[RedwoodSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [[UserManager sharedInstance] setCurrentUser:user];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


- (IBAction)unwindToHomePage:(UIStoryboardSegue *)segue{
    [self performSelector:@selector(performSegueWithIdentifier:sender:) withObject:@"Posts" afterDelay:0.0f];
}

@end
