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
#import "MyUIButton.h"
#import "ImgFullViewController.h"
#import "L1Button.h"
#import "L2Button.h"


#define FRAME_LSide_ToolBar_W 35
#define FRAME_LSide_ToolBar_H 110
#define FRAME_LSide_ToolBar_First_X 65
#define FRAME_LSide_ToolBar_Frist_Y 160

#define FRAME_RSide_ToolBar_W FRAME_LSide_ToolBar_W
#define FRAME_RSide_ToolBar_H FRAME_LSide_ToolBar_H
#define FRAME_RSide_ToolBar_First_X (SCREEN_W - FRAME_LSide_ToolBar_First_X - FRAME_RSide_ToolBar_W)
#define FRAME_RSide_ToolBar_Frist_Y FRAME_LSide_ToolBar_Frist_Y


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
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerFromIndex:0 endIndex:ITEMS_PER_PAGE-1 withDetailViewController:detailViewController];
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rootBackground.png"]];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;//CGRectMake(120, 60, 600, 600);//self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, RECT_INSET_W, RECT_INSET_H);
    
    self.pageViewController.view.frame = pageViewRect;
    self.pageViewController.view.center = CGPointMake(382, 540);
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

    [self setVcType:ViewControllerProduct andSubType:nil];
    DetailViewController *detailViewController= [[DetailViewController alloc]init];
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerFromIndex:0 endIndex:ITEMS_PER_PAGE - 1 withDetailViewController:detailViewController];
    [productViewController setPageCount:[self.modelController pageCount]];
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
    [self.pageViewController setViewControllers:@[vc1, vc2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
     }];
}

- (void)loadToolBar
{
    DataAdapter* da = [DataAdapter shareInstance];
    NSArray* rootProductType = [da productTypeForParent:PRODUCT_TYPE_ROOT];
    int counter = 0;
    for (ProductType* type in rootProductType)
    {
        L1Button *btnL1 = [[L1Button alloc]initAll:CGRectMake(FRAME_LSide_ToolBar_First_X, FRAME_LSide_ToolBar_Frist_Y+FRAME_LSide_ToolBar_H*counter++, FRAME_LSide_ToolBar_W, FRAME_LSide_ToolBar_H) andVcType:ViewControllerProduct andSubType:type.productType andTitle:type.typeName andStyle:MyUIButtonStyleLeft andImgName:@"defaultL1Btn.png" andRvc:self];
        [self.view addSubview:btnL1];
    }
    
    
    MyUIButton* toolBarMap = [[MyUIButton alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andVcType:ViewControllerMap andSubType:nil andTitle:@"分店介绍" andStyle:MyUIButtonStyleRight andImgName:@"defaultL1Btn.png" andRvc:self];
    [self.view addSubview:toolBarMap];
    MyUIButton* btnPolicy = [[MyUIButton alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y+FRAME_RSide_ToolBar_H, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andVcType:ViewControllerPolicy andSubType:nil andTitle:@"优惠政策" andStyle:MyUIButtonStyleRight andImgName:@"defaultL1Btn.png" andRvc:self];
    [self.view addSubview:btnPolicy];
    MyUIButton* btnShoppingCart = [[MyUIButton alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y+FRAME_RSide_ToolBar_H*2, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andVcType:ViewControllerShoppingCart andSubType:nil andTitle:@"购物车" andStyle:MyUIButtonStyleRight andImgName:@"defaultL1Btn.png" andRvc:self];
    [self.view addSubview:btnShoppingCart];
    /*
    btn.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"btnProduct.png"]];
    btn.titleLabel.text = @"AAAAABBBBCCCC";
    btn.titleLabel.numberOfLines = 0;
    [btn setTitle:@"女\n士\n发\n型" forState:UIControlStateNormal];
   // btn.titleLabel.textAlignment = UITextAlignmentRight;
    //btn.titleLabel.bounds = CGRectMake(0,0,20,btn.titleLabel.bounds.size.width);
    btn.titleLabel.center = CGPointMake(btn.center.x+20, btn.center.y+20);
    btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    btn.titleLabel.textColor = [UIColor blackColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [btn.titleLabel sizeToFit];
     */

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
