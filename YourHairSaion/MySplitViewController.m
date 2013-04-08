//
//  MySplitViewController.m
//  UITest3
//
//  Created by chen loman on 12-11-9.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MySplitViewController.h"
#import "TabBarViewController1.h"
#import "NGTabBarController.h"
#import "TabBarViewController2.h" 
#import "TabBarViewController3.h"
#import "TabBarViewController4.h"
#import "PSViewController.h"

@interface MySplitViewController ()

@end


@implementation MySplitViewController
@synthesize tabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTabbarController];
    self.contentSizeForViewInPopover = CGSizeMake(800, 500);
    //[self setValue:[NSNumber numberWithFloat:500.0] forKey:@"_masterColumnWidth"];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
[self setValue:[NSNumber numberWithFloat:512.0] forKey:@"_masterColumnWidth"];
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (CGSize)tabBarController:(NGTabBarController *)tabBarController
sizeOfItemForViewController:(UIViewController *)viewController
                   atIndex:(NSUInteger)index
                  position:(NGTabBarPosition)position {
    if (NGTabBarIsVertical(position)) {
        return CGSizeMake(50, 100);
    } else {
        return CGSizeMake(30, 100);
    }
}
- (void)loadTabbarController
{
    self.tabBarController = [[NGTabBarController alloc ]initWithDelegate:self];
    TabBarViewController1 *tbc1 = [[TabBarViewController1 alloc] init];
    tbc1.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"ONE" image:[UIImage imageNamed:@"liveradio.png"]];
    PSViewController *tbc2 = [[PSViewController alloc] init];
    tbc2.rootview = self;
    tbc2.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"TWO" image:[UIImage imageNamed:@"myradio.png"]];
    TabBarViewController3 *tbc3 = [[TabBarViewController3 alloc] init];
    tbc3.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"THREE" image:[UIImage imageNamed:@"news.png"]];
    TabBarViewController4 *tbc4 = [[TabBarViewController4 alloc] init];
    tbc4.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"FOUR" image:[UIImage imageNamed:@"ondemand.png"]];
    NSMutableArray *splitVCs = [NSMutableArray arrayWithArray:self.viewControllers];
    NSArray *subVCs = [NSArray arrayWithObjects:tbc2,tbc1,tbc3, tbc4, nil];
    self.tabBarController.viewControllers = subVCs;
    [splitVCs insertObject:self.tabBarController atIndex:0];
    self.viewControllers = splitVCs;

    
    
    
}
@end
