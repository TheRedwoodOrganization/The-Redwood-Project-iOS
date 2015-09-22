//
//  HomePageViewController.m
//  The_Redwood_Project
//
//  Created by Jean Smits on 21/09/15.
//  Copyright (c) 2015 Redwood. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@property (strong, nonatomic) NSMutableArray *postArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    PFObject *gameScore = [PFObject objectWithClassName:@"BlogPost"];
//    gameScore[@"postBody"] = @"Testing parse via iOS";
//    gameScore[@"postTitle"] = @"Sean Plott";
//    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
            // The object has been saved.
//        } else {
            // There was a problem, check error.description
//        }
//    }];
//    self.postArray = [[NSMutableArray alloc]init];
//    PFQuery *query = [PFQuery queryWithClassName:@"BlogPost"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error){
//            for (PFObject *pfObject in objects) {
//                Post *post = [[Post alloc]init];
//                post.title = [pfObject objectForKey:@"postTitle"];
//                
//                NSDateFormatter *df = [[NSDateFormatter alloc] init];
//                [df setDateFormat:@"yyy-MM-dd"];
//                post.doc = [df stringFromDate:pfObject.createdAt];
//                [self.postArray addObject:post];
//                
//            };
//            
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    PostTableViewController *viewController = segue.destinationViewController;
//    viewController.postArray = self.postArray;
//}



@end
