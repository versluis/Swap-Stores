//
//  FlipsideViewController.h
//  SwapStores
//
//  Created by Jay Versluis on 20/12/2013.
//  Copyright (c) 2013 Pinkstone Pictures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
