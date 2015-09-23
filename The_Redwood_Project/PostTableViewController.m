//
//  PostTableViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostTableViewController.h"
#import "PostDetailViewController.h"

@interface PostTableViewController ()

@property (assign, nonatomic) NSInteger indexNumber;
@property (assign, nonatomic) BOOL done;

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillArray];
    
    
}

-(void)fillArray{
    self.postArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Blog"];
    [innerquery whereKey:@"objectId" equalTo:self.receivedblog.parseId];
    PFObject *blog = [innerquery getFirstObject];
    
    [query whereKey:@"blog" equalTo:blog];
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
            [self.tableView reloadData];
            
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexNumber = indexPath.row;
    self.thisPost = self.postArray[self.indexNumber];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@" ,self.thisPost.title]
                                                                   message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *reviewsAction = [UIAlertAction actionWithTitle:@"Read the Post." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
         [self performSegueWithIdentifier:@"Detail" sender:self];
    }];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit the Post." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // [self performSegueWithIdentifier:@"EditSegue" sender:self];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete this Post." style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        UIAlertController *sure = [UIAlertController alertControllerWithTitle:self.thisPost.title message:@"Are you sure you want to delete this post?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            // [self.sessionManager deleteBook:self.receivedBookArray[self.indexNumber]];
        }];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [sure addAction:noAction];
        [sure addAction:yesAction];
        [self presentViewController:sure animated:YES completion:nil];
        
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:reviewsAction];
    [alert addAction:editAction];
    [alert addAction:deleteAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PostDetailViewController *viewController = (PostDetailViewController *)segue.destinationViewController;
    viewController.receivedPost = self.postArray[self.tableView.indexPathForSelectedRow.row];
    viewController.title = viewController.receivedPost.title;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
