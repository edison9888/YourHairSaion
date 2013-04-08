//
//  DetailViewController.m
//  UITest3
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MyDetailViewController.h"

@interface MyDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation MyDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
        [self.masterPopoverController setPopoverContentSize:CGSizeMake(800, 1004)];
        [[self.masterPopoverController contentViewController] setContentSizeForViewInPopover:CGSizeMake(800, 1004)];
    }        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = @"TESTTEST";//[[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"AAAAA%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = CGRectMake(0, 20, 400, 1004);
    [self configureView];
    NSLog(@"AAAAA%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = CGRectMake(0, 20, 600, 1004);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
   
    [UIView commitAnimations];
    for (UIView* v in self.view.subviews)
    {
        if ([v isKindOfClass:[UIImageView class]])
        {
            UIImageView* iv = v;
            iv.frame = CGRectMake(0,0,400,400);
            //iv.center = self.view.center;
            iv.center = CGPointMake(256, 324);
            iv.contentMode = UIViewContentModeScaleAspectFill;
            
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    [popoverController setPopoverContentSize:CGSizeMake(800, 1004)];
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
    
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    //[self.navigationItem set]
    self.masterPopoverController = nil;
    [viewController setContentSizeForViewInPopover:CGSizeMake(800, 1004)];
}
- (void)doSomething
{
    NSLog(@"do something");
}
@end
