//
//  MainViewController.m
//  SwapStores
//
//  Created by Jay Versluis on 20/12/2013.
//  Copyright (c) 2013 Pinkstone Pictures LLC. All rights reserved.
//

#import "MainViewController.h"
#import "Event.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// [self createSomeData];
    [self showData];
    [self swapStores];
    [self showData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark -

- (void)createSomeData {
    
    // generate a few managed objects so we can work with them
    for (int i = 1; i <= 10; i++) {
        Event *newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
        NSString *newEntry = [NSString stringWithFormat:@"Store 2 Log Entry No. %i", i];
        newEvent.logEntry = newEntry;
    }
    [self.managedObjectContext save:nil];
    NSLog(@"Done creating data.");
}

- (void)showData {
    
    // prints out all existing log entries to NSLog
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"logEntry"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
        NSLog(@"There was a problem fetching our data... sorry!");
    }
    
    NSLog(@"\nHere come the log entries:");
    for (Event *event in fetchedObjects) {
        NSLog(@"%@", event.logEntry);
    }
    NSLog(@"\n End of listing.");
}


- (void)swapStores {
    
    // switch out store1 and replace it with store 2
    
    AppDelegate *myAppDelegate = [[AppDelegate alloc]init];
    NSURL *store1 = [myAppDelegate.applicationDocumentsDirectory URLByAppendingPathComponent:@"Store1.sqlite"];
    NSURL *store2 = [myAppDelegate.applicationDocumentsDirectory URLByAppendingPathComponent:@"Store2.sqlite"];
    
    NSError *error = nil;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:store2 options:@{NSSQLitePragmasOption: @{@"journal_mode": @"delete"}} error:&error]) {
        NSLog(@"Couldn't add the second persistent store. Error was: %@", error);
    }
    
    error = nil;
    NSPersistentStore *firstStore = [self.persistentStoreCoordinator persistentStoreForURL:store1];
    if (![self.persistentStoreCoordinator removePersistentStore:firstStore error:&error]) {
        NSLog(@"Could not remove first store. Error was: %@", error);
    }
}

@end
