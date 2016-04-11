//
//  ViewController.h
//  NoteTake
//
//  Created by Mengistayehu Mamo on 11/8/15.
//  Copyright © 2015 Mengistayehu Mamo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *topicName;
@property (weak, nonatomic) IBOutlet UITextView *noteText;

@property(strong,nonatomic)NSManagedObject *devices;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;


@end

