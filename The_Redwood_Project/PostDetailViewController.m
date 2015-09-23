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


@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.text = self.receivedPost.content;
    
    [self fillArray];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fillArray{
    self.commentArray = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"BlogPost"];
    [innerquery whereKey:@"objectId" equalTo:self.receivedPost.parseId];
    PFObject *post = [innerquery getFirstObject];
    
    [query whereKey:@"blogPost" equalTo:post];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            for (PFObject *pfObject in objects) {
                Comment *comm = [[Comment alloc]init];
                comm.content = [pfObject objectForKey:@"commentText"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyy-MM-dd"];
                comm.doc = [df stringFromDate:pfObject.updatedAt];
                [self.commentArray addObject:comm];
                
            };
            [self.tableView reloadData];
            
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
    
    return cell;
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
