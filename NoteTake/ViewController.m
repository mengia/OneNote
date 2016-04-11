//
//  ViewController.m
//  NoteTake
//
//  Created by Mengistayehu Mamo on 11/8/15.
//  Copyright © 2015 Mengistayehu Mamo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteText.layer.borderColor = [[UIColor grayColor] CGColor];
    self.noteText.layer.borderWidth = 0.9;
    self.noteText.layer.cornerRadius = 8.0;

    
    
    
    if(self.devices){
        [self.topicName setText:[self.devices valueForKey:@"topicName"]];
        [self.noteText setText:[self.devices valueForKey:@"noteText"]];
        
    }

    // Do any additional setup after loading the view, typically from a nib.
    
}

-(NSManagedObjectContext*)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context =[delegate managedObjectContext];
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

- (IBAction)cancel:(id)sender { 
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    [self managedObjectContext];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(self.devices){
        [self.topicName setText:[self.devices valueForKey:@"topicName"]];
        [self.noteText setText:[self.devices valueForKey:@"noteText"]];
    } else
    {
    NSManagedObject *objectId = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [objectId setValue:self.topicName.text forKey:@"topicName"];
    [objectId setValue:self.noteText.text forKey:@"noteText"];
    }
    
    NSError *error;
    if([context save:&error]){
        NSLog(@"can't save %@",[error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
