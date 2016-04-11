//
//  MasterTableViewController.m
//  NoteTake
//
//  Created by Mengistayehu Mamo on 11/8/15.
//  Copyright © 2015 Mengistayehu Mamo. All rights reserved.
//

#import "MasterTableViewController.h"

@interface MasterTableViewController ()
@property(strong,nonatomic)NSMutableArray *deviceArray;


@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSManagedObjectContext *managedContext = [self managedObjectContext];
    NSFetchRequest *requestFetch = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.deviceArray = [[managedContext executeFetchRequest:requestFetch error:nil] mutableCopy];
    
    
    [self.tableView reloadData];
    
}

-(NSManagedObjectContext*)managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        
        context = [delegate managedObjectContext];
    }
    return context;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSManagedObject *managedObject = [self.deviceArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[managedObject valueForKey:@"topicName"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[managedObject valueForKey:@"noteText"]]];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [context deleteObject:[self.deviceArray objectAtIndex:indexPath.row]];
        
        NSError *error;
        if(![context save:&error]){
            NSLog(@"Can't save the Data %@",[error localizedDescription]);
        }
        [self.deviceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"updateSague"]){
        
        NSManagedObject *selectedDevice =[self.deviceArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        MasterTableViewController *destinationView = segue.destinationViewController;
        destinationView.devices = selectedDevice;
        
    }
}


@end
