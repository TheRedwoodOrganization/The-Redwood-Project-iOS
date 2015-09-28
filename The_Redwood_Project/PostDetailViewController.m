//
//  PostDetailViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 23/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "PostDetailViewController.h"
#import "CommentTableViewCell.h"


@interface PostDetailViewController ()


@property (weak, nonatomic) IBOutlet UITextView *content;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (strong, nonatomic) PFUser *ownerUser;

@property (strong, nonatomic) CommentHeaderTableViewCell *chtvc;

@property (strong, nonatomic) NSString *freshComment;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkUser];
    
    self.content.text = self.receivedPost.content;
    if (![[[PFUser currentUser] objectForKey:@"hasBlog"] boolValue] || self.ownerUser != [PFUser currentUser]) {
        NSMutableArray *toolbarButtons = [self.navigationItem.rightBarButtonItems mutableCopy];
        [toolbarButtons removeObject:self.editButton];
        [self.navigationItem  setRightBarButtonItems:toolbarButtons animated:YES];
    }
    
    [self fillArray];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkUser{
    PFQuery *curPostQuery = [PFQuery queryWithClassName:@"BlogPost"];
    [curPostQuery whereKey:@"objectId" equalTo:self.receivedPost.parseId];
    [curPostQuery includeKey:@"user"];
    PFObject *curPost = [curPostQuery getFirstObject];
    NSString *curPostUserId = [curPost[@"user"]objectId];
    self.ownerUser = [PFQuery getUserObjectWithId:curPostUserId];
}

-(void)fillArray{
    self.commentArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"BlogPost"];
    [innerquery whereKey:@"objectId" equalTo:self.receivedPost.parseId];
    PFObject *post = [innerquery getFirstObject];
    
    [query whereKey:@"blogPost" equalTo:post];
    [query orderByDescending:@"updatedAt"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            for (PFObject *pfObject in objects) {
                Comment *comm = [[Comment alloc]init];
                comm.content = [pfObject objectForKey:@"commentText"];
                
                NSString *userId = [pfObject[@"user"]objectId];
                PFUser *curUser = [PFQuery getUserObjectWithId:userId];
                User *foundUser = [[User alloc]init];
                foundUser.userName = [curUser objectForKey:@"username"];
                comm.user = foundUser;
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyy-MM-dd"];
                comm.doc = [df stringFromDate:pfObject.updatedAt];
                [self.commentArray addObject:comm];
                
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment" forIndexPath:indexPath];
    if (self.commentArray.count != 0){
        Comment *comm = self.commentArray[indexPath.row];
        [cell createCells:comm];
    }
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2) {
        UIColor *myColor =  [UIColor colorWithRed:(206 / 255.0) green:(235 / 255.0) blue:(245 / 255.0) alpha:1.0];
        cell.backgroundColor = myColor;
    }

}

- (void)commentIsReady:(NSString *)commentContent{
    self.freshComment = commentContent;
    [self addComment];
}

- (void)addComment {
    PFObject *createdComment = [PFObject objectWithClassName:@"Comment"];
        createdComment[@"user"] = self.currentUser;
        createdComment[@"commentText"] = self.freshComment;
    
        PFQuery *innerquery = [PFQuery queryWithClassName:@"BlogPost"];
        [innerquery whereKey:@"objectId" equalTo:self.receivedPost.parseId];
        PFObject *post = [innerquery getFirstObject];
        createdComment[@"blogPost"] = post;
        [createdComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self fillArray];
            } else {
            }
        }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CommentHeaderTableViewCell *header = [tableView dequeueReusableCellWithIdentifier:@"CommentHeader"];
    UIColor *myColor =  [UIColor colorWithRed:(120 / 255.0) green:(191 / 255.0) blue:(214 / 255.0) alpha:1.0];
    header.backgroundColor = myColor;
    header.delegate = self;
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Comment *comm = self.commentArray[indexPath.row];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14.0f] };
    CGSize maxSize = CGSizeMake(CGRectGetWidth(tableView.frame), NSIntegerMax);
    CGRect boundingRect = [comm.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
 
    NSLog(@"%@ - %f", comm.content, boundingRect.size.height);
    return boundingRect.size.height + 18.0f + 6.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80.0f;
}

- (IBAction)editClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@" ,self.receivedPost.title]
                                                                   message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit this Post." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // [self performSegueWithIdentifier:@"EditSegue" sender:self];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete this Post." style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        UIAlertController *sure = [UIAlertController alertControllerWithTitle:self.receivedPost.title message:@"Are you sure you want to delete this post?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            PFQuery *innerquery = [PFQuery queryWithClassName:@"BlogPost"];
            [innerquery whereKey:@"objectId" equalTo:self.receivedPost.parseId];
            PFObject *post = [innerquery getFirstObject];
            [post deleteInBackground];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [sure addAction:noAction];
        [sure addAction:yesAction];
        [self presentViewController:sure animated:YES completion:nil];
        
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];

    
    [alert addAction:editAction];
    [alert addAction:deleteAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
