//
//  PostTableViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostTableViewController.h"
#import "PostDetailViewController.h"
#import "UserManager.h"

@interface PostTableViewController ()

@property (assign, nonatomic) NSInteger indexNumber;
@property (assign, nonatomic) BOOL done;
@property (strong, nonatomic) PFUser *ownerUser;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkUser];
    if (![[[[UserManager sharedInstance] currentUser] objectForKey:@"hasBlog"] boolValue] || self.ownerUser != [[UserManager sharedInstance] currentUser]) {
        NSMutableArray *toolbarButtons = [self.navigationItem.rightBarButtonItems mutableCopy];
        [toolbarButtons removeObject:self.addButton];
        [self.navigationItem  setRightBarButtonItems:toolbarButtons animated:YES];
    }

}

- (void)popToRoot:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [self fillArray];
}

-(void)checkUser{
    PFQuery *curPostQuery = [PFQuery queryWithClassName:@"Blog"];
    [curPostQuery whereKey:@"objectId" equalTo:self.receivedblog.parseId];
    [curPostQuery includeKey:@"user"];
    PFObject *curPost = [curPostQuery getFirstObject];
    NSString *curPostUserId = [curPost[@"user"]objectId];
    self.ownerUser = [PFQuery getUserObjectWithId:curPostUserId];
}


-(void)fillArray{
    self.postArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Blog"];
    [innerquery whereKey:@"objectId" equalTo:self.receivedblog.parseId];
    PFObject *blog = [innerquery getFirstObject];
    
    [query whereKey:@"blog" equalTo:blog];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            for (PFObject *pfObject in objects) {
                Post *post = [[Post alloc]init];
                post.title = [pfObject objectForKey:@"postTitle"];
                post.parseId = pfObject.objectId;
                post.content = [pfObject objectForKey:@"postBody"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyy-MM-dd"];
                post.doc = [df stringFromDate:pfObject.createdAt];
                [self.postArray addObject:post];
                
            };
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.postArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Post" forIndexPath:indexPath];
    if (self.postArray.count != 0){
        Post *post = self.postArray[indexPath.row];
        [cell createCells:post];
    }

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PostHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostHeader"];
    [cell createCells:self.receivedblog];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Detail" sender:self];
    }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detail"]){
        PostDetailViewController *viewController = (PostDetailViewController *)segue.destinationViewController;
    viewController.receivedPost = self.postArray[self.tableView.indexPathForSelectedRow.row];
    viewController.title = viewController.receivedPost.title;
        viewController.currentUser = self.ownerUser;
    } else if ([segue.identifier isEqualToString:@"CreatePost"]){
        UINavigationController* navigationController = segue.destinationViewController;
        PostCreationViewController *viewController = (PostCreationViewController *)navigationController.topViewController;
        viewController.creatorUser = self.ownerUser;
        viewController.currentBlog = self.receivedblog;
        viewController.title = @"Write a new Post";
    }
}
-(IBAction)unwindToPostsClicked:(UIStoryboardSegue *)segue{
    [self performSelector:@selector(fillArray) withObject:nil afterDelay: 0.1f];
}


@end
