//
//  MasterTableViewController.h
//  NoteTake
//
//  Created by Mengistayehu Mamo on 11/8/15.
//  Copyright © 2015 Mengistayehu Mamo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface MasterTableViewController : UITableViewController
@property(strong,nonatomic)NSManagedObject *devices;

@end  
