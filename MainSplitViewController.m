//
//  MainSplitViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-15.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MainSplitViewController.h"
#import "TabBarViewController1.h"
#import "NGTabBarController.h"
#import "TabBarViewController2.h"
#import "TabBarViewController4.h"
#import "ProductViewController.h"
#import "DetailViewController.h"
#import "ShoppingCartViewController.h"
#import "MapViewController.h"
#import "MyTabBarViewController.h"


@interface MainSplitViewController ()
- (void)loadTabbarController;
- (void)loadTabbarControllerLeft;
- (void)loadTabbarControllerRight;
@end

@implementation MainSplitViewController
@synthesize leftTabBarController, rightTabBarController;

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
    self.splitWidth = 0;
    [self setSplitPosition:SPLIT_POSITION_MID];
    [self loadTabbarController];
    self.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)loadTabbarController
{
    [self loadTabbarControllerLeft];
    [self loadTabbarControllerRight];
}
- (void)loadTabbarControllerLeft
{
    self.leftTabBarController = [[MyTabBarViewController alloc ]initWithDelegate:self];
    [self.leftTabBarController.tabBar setTintColor:[UIColor whiteColor]];
    self.leftTabBarController.tabBar.frame = CGRectMake(0,0,300,768);
    //self.leftTabBarController.tabBarController.view.backgroundColor = [UIColor clearColor];
    ProductViewController *tbc1 = [[ProductViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:tbc1];
    tbc1.rootViewController = self;
    nav1.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"发型选择" image:[UIImage imageNamed:@"myradio.png"]];
    
    
    TabBarViewController2 *tbc2 = [[TabBarViewController2 alloc] init];
    tbc2.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"优惠政策" image:[UIImage imageNamed:@"liveradio.png"]];
    tbc2.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
    MapViewController *tbc3 = [[MapViewController alloc] init];
    tbc3.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"分店介绍" image:[UIImage imageNamed:@"news.png"]];
    tbc3.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    ShoppingCartViewController *tbc4 = [[ShoppingCartViewController alloc] init];
    tbc4.rootview = self;
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:tbc4];
    nav4.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"购物车" image:[UIImage imageNamed:@"ondemand.png"]];
    tbc4.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSMutableArray *splitVCs = [NSMutableArray arrayWithArray:self.viewControllers];
    NSArray *subVCs = [NSArray arrayWithObjects:nav1, tbc2, tbc3,nav4, nil];
    self.leftTabBarController.viewControllers = subVCs;
    [splitVCs insertObject:self.leftTabBarController atIndex:0];
    self.viewControllers = splitVCs;

}
- (void)loadTabbarControllerRight
{
    self.rightTabBarController = [[NGTabBarController alloc ]initWithDelegate:self];
    self.rightTabBarController.tabBarPosition = NGTabBarPositionRight;
    TabBarViewController1 *tbc1 = [[TabBarViewController1 alloc] init];
    //UINavigationController* nav1 = [[UIStoryboard storyboardWithName:@"DetailViewStoryboard" bundle:nil] instantiateInitialViewController];
    DetailViewController* detailViewController = [[DetailViewController alloc]init];
    UINavigationController* nav1 = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    detailViewController.rootViewController = self;
    nav1.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"ONE" image:[UIImage imageNamed:@"liveradio.png"]];
    tbc1.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"ONE" image:[UIImage imageNamed:@"liveradio.png"]];
    tbc1.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    ProductViewController *tbc2 = [[ProductViewController alloc] init];
    tbc2.rootview = self;
    tbc2.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"TWO" image:[UIImage imageNamed:@"myradio.png"]];
    tbc2.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    /*
    TabBarViewController3 *tbc3 = [[TabBarViewController3 alloc] init];
    tbc3.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"THREE" image:[UIImage imageNamed:@"news.png"]];
    tbc3.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
     */
    TabBarViewController4 *tbc4 = [[TabBarViewController4 alloc] init];
    tbc4.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"FOUR" image:[UIImage imageNamed:@"ondemand.png"]];
    tbc4.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSMutableArray *splitVCs = [NSMutableArray arrayWithArray:self.viewControllers];
    NSArray *subVCs = [NSArray arrayWithObjects:nav1,tbc1, tbc4, nil];
    self.rightTabBarController.viewControllers = subVCs;
    self.rightTabBarController.view.frame = CGRectMake(512, 20, 512, 748);
    [splitVCs setObject:self.rightTabBarController atIndexedSubscript:1];
    self.viewControllers = splitVCs;

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

- (void)tabBarController:(NGTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
    if (tabBarController.tabBarPosition == NGTabBarPositionLeft)
    {
        switch (index)
        {
            case LeftTabBarViewControllerProduct:
            case LeftTabBarViewControllerShoppingCart:
                [self setSplitPosition:SPLIT_POSITION_MID];
                self.rightTabBarController.tabBarHidden = NO;
                //[self.rightTabBarController.view layoutSubviews];
                break;
            default:
                [self setSplitPosition:SPLIT_POSITION_RIGHT_END];
                self.rightTabBarController.tabBarHidden = YES;
                break;
        }
    }
}

- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}

- (void)splitViewController:(MGSplitViewController*)svc
		  popoverController:(UIPopoverController*)pc
  willPresentViewController:(UIViewController *)aViewController
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}






@end
