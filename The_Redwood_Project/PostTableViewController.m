//
//  PostTableViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostTableViewController.h"

@interface PostTableViewController ()

@property (assign, nonatomic) NSInteger indexNumber;

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    //return self.postArray.count;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Post" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.row];
    post.title = @"Test";
    [cell createCells:post];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexNumber = indexPath.row;
    self.thisPost = self.postArray[self.indexNumber];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@" ,self.thisPost.title]
                                                                   message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *reviewsAction = [UIAlertAction actionWithTitle:@"Read the Post." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // [self performSegueWithIdentifier:@"ReviewSegue" sender:self];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end