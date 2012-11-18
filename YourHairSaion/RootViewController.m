//
//  RootViewController.m
//  PageTest
//
//  Created by chen loman on 12-11-16.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "RootViewController.h"

#import "ModelController.h"

#import "DetailViewController.h"
#import "TabBarViewController1.h"
#import "NGTabBarController.h"
#import "TabBarViewController2.h"
#import "TabBarViewController4.h"
#import "ProductViewController.h"
#import "DetailViewController.h"
#import "ShoppingCartViewController.h"
#import "MapViewController.h"
#import "MyTabBarViewController.h"
#import "MyToolBar.h"


#define FRAME_LSide_ToolBar_W 60
#define FRAME_LSide_ToolBar_H 110
#define FRAME_LSide_ToolBar_First_X 77
#define FRAME_LSide_ToolBar_Frist_Y 179

#define FRAME_RSide_ToolBar_W 60
#define FRAME_RSide_ToolBar_H 110
#define FRAME_RSide_ToolBar_First_X 1024 - 77
#define FRAME_RSide_ToolBar_Frist_Y 179


@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
- (void)loadTabbarController;
- (void)loadTabbarControllerLeft;
- (void)loadTabbarControllerRight;
- (void)loadToolBar;

@end

@implementation RootViewController

@synthesize modelController = _modelController;
@synthesize leftTabBarController, rightTabBarController;
@synthesize leftToolBar;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DetailViewController *detailViewController= [[DetailViewController alloc]init];
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerFromIndex:0 endIndex:8 withDetailViewController:detailViewController];
    detailViewController.productViewController = productViewController;
    [productViewController viewDidLoad];
    //[self loadTabbarController];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    //DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    //NSArray *viewControllers = @[startingViewController];
//    NGTabBarItem* item1 = [[NGTabBarItem alloc]init];
//    item1.title = @"发行发行";
//    [self.leftTabBar setItems:[NSArray arrayWithObject:item1]];
//    self.leftTabBar.frame = CGRectMake(0, 0, 100, 768);
    
    [self loadToolBar];
    NSArray* viewControllers = [NSArray arrayWithObjects:self.productViewController,self.detailViewController, nil];
    [self.pageViewController setViewControllers:@[productViewController, detailViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

    self.pageViewController.dataSource = self.modelController;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.JPG"]];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;//CGRectMake(120, 60, 600, 600);//self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 120, 60);
    
    self.pageViewController.view.frame = pageViewRect;
    self.pageViewController.view.center = CGPointMake(384, 530);
    self.pageViewController.view.clipsToBounds = YES;
    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    //self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
        _modelController.rootViewController = self;
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return nil;
    }

    DetailViewController *detailViewController= [[DetailViewController alloc]init];
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerFromIndex:0 endIndex:8 withDetailViewController:detailViewController];
    detailViewController.productViewController = productViewController;
    [self.pageViewController setViewControllers:@[productViewController, detailViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    

    return UIPageViewControllerSpineLocationMid;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType
{
    [self.modelController setVcType:enumVcType andSubType:subType];
    UIViewController* vc1 = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    UIViewController* vc2 = [self.modelController viewControllerAtIndex:1 storyboard:self.storyboard];
    [self.pageViewController setViewControllers:@[vc1, vc2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)loadToolBar
{
    MyToolBar* toolBarProduct1 = [[MyToolBar alloc]initAll:CGRectMake(FRAME_LSide_ToolBar_First_X, FRAME_LSide_ToolBar_Frist_Y, FRAME_LSide_ToolBar_W, FRAME_LSide_ToolBar_H) andVcType:ViewControllerProduct andSubType:((ProductType*)[DataAdapter shareInstance].productTypes[0]).productType andImgName:@"btnProduct.png" andRvc:self];
    [self.view addSubview:toolBarProduct1];
    MyToolBar* toolBarProduct2 = [[MyToolBar alloc]initAll:CGRectMake(FRAME_LSide_ToolBar_First_X, FRAME_LSide_ToolBar_Frist_Y+FRAME_LSide_ToolBar_H, FRAME_LSide_ToolBar_W, FRAME_LSide_ToolBar_H) andVcType:ViewControllerProduct andSubType:((ProductType*)[DataAdapter shareInstance].productTypes[1]).productType andImgName:@"btnProduct.png" andRvc:self];
    [self.view addSubview:toolBarProduct2];
    
    MyToolBar* toolBarMap = [[MyToolBar alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y+FRAME_RSide_ToolBar_H, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andVcType:ViewControllerMap andSubType:nil andImgName:@"btnProduct.png" andRvc:self];
    [self.view addSubview:toolBarMap];
}

@end
