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
#import "ProductViewController.h"
#import "DetailViewController.h"
#import "MapViewController.h"
#import "MyTabBarViewController.h"
#import "MyUIButton.h"
#import "ImgFullViewController.h"
#import "L1Button.h"
#import "L2Button.h"
#import "L1MapButton.h"
#import "StatementViewController.h"
#import "ProductPagePolicy.h"
#import "ListMapPagePolicy.h"
#import "ShoppingCartPagePolicy.h"
#import "DiscountPagePolicy.h"
#import "SearchPagePolicy.h"



#define FRAME_LSide_ToolBar_W 78
#define FRAME_LSide_ToolBar_H 186
#define FRAME_LSide_ToolBar_First_X 72
#define FRAME_LSide_ToolBar_Frist_Y 150

#define FRAME_RSide_ToolBar_W FRAME_LSide_ToolBar_W
#define FRAME_RSide_ToolBar_H FRAME_LSide_ToolBar_H
#define FRAME_RSide_ToolBar_First_X (SCREEN_W - FRAME_LSide_ToolBar_First_X - FRAME_RSide_ToolBar_W)
#define FRAME_RSide_ToolBar_Frist_Y FRAME_LSide_ToolBar_Frist_Y


@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
@property (nonatomic, strong)NSMutableArray* opArray;
@property (nonatomic, assign)int opIndex;

- (void)loadToolBar;

@end

@implementation RootViewController

@synthesize modelController = _modelController;
@synthesize l1Btns, imgFullViewController,statementViewController, btnOpBack, btnOpForward;
- (void)viewDidLoad
{
    /*
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    //指向文件目录
    NSString *documentsDirectory= [[DataAdapter shareInstance]path];
    
    //创建一个目录
    [fileMgr createDirectoryAtPath: [NSString stringWithFormat:@"%@/IMG", documentsDirectory] attributes:nil];
    [fileMgr createDirectoryAtPath: [NSString stringWithFormat:@"%@/IMG/Product", documentsDirectory] attributes:nil];
     */
    [super viewDidLoad];
    self.opArray = [[NSMutableArray alloc]init];
    self.opIndex = -1;
    self.imgFullViewController = [[ImgFullViewController alloc]init];
    self.statementViewController = [[StatementViewController alloc]init];
    /*
    DetailViewController *detailViewController= [[DetailViewController alloc]init];
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerFromIndex:0 endIndex:ITEMS_PER_PAGE-1 withDetailViewController:detailViewController];
    detailViewController.productViewController = productViewController;
     */
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
    //[self.pageViewController setViewControllers:@[productViewController, detailViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

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
    for (UIGestureRecognizer* gr in self.pageViewController.gestureRecognizers)
    {
        gr.delegate = self;
    }
    
    
    [((L1Button*)self.l1Btns[0]) sendActionsForControlEvents:UIControlEventTouchUpInside];
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


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}


- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    [self setPagePolicy:[[ProductPagePolicy alloc]initWithSubType:((ProductType*)[DataAdapter shareInstance].productTypes[0]).productType]];
    DetailViewController *detailViewController= [[DetailViewController alloc]init];
    ProductViewController* productViewController = [[ProductViewController alloc]initProductViewControllerWithTitle:@"女士发型" fromIndex:0 endIndex:ITEMS_PER_PAGE - 1 withDetailViewController:detailViewController];
    productViewController.rootViewController = self;
    detailViewController.psViewController = productViewController;
    productViewController.detailViewController = detailViewController;
    
    [productViewController setPageCount:[self.modelController pageCount]];
    detailViewController.psViewController = productViewController;
    [self.pageViewController setViewControllers:@[productViewController, detailViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    return UIPageViewControllerSpineLocationMid;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

/*
- (void)setVcType:(enumViewControllerType)enumVcType andSubType:(NSString *)subType
{
    
    [self.modelController setVcType:enumVcType andSubType:subType];
    UIViewController* vc1 = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    UIViewController* vc2 = [self.modelController viewControllerAtIndex:1 storyboard:self.storyboard];
    [self.pageViewController setViewControllers:@[vc1, vc2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
     }];
}
 */

- (void)loadToolBar
{
    DataAdapter* da = [DataAdapter shareInstance];
    NSArray* rootProductType = [da productTypeForParent:PRODUCT_TYPE_ROOT];
    int counter = 0;
    self.l1Btns = [[NSMutableArray alloc]init];
    for (ProductType* type in rootProductType)
    {
        L1Button *btnL1 = [[L1Button alloc]initAll:CGRectMake(FRAME_LSide_ToolBar_First_X, FRAME_LSide_ToolBar_Frist_Y+FRAME_LSide_ToolBar_H*counter++, FRAME_LSide_ToolBar_W, FRAME_LSide_ToolBar_H) andPagePolicy:[[ProductPagePolicy alloc] initWithSubType:type.productType] andTitle:type.typeName andStyle:MyUIButtonStyleLeft andImgName:[NSString stringWithFormat:@"ll1Btn%d.png", counter] andRvc:self];
        [self.view addSubview:btnL1];
        [l1Btns addObject:btnL1];
    }
    
    
    L1MapButton* btnMap = [[L1MapButton alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andPagePolicy:[[ListMapPagePolicy alloc] initWithSubType:@""] andTitle:@"分店介绍" andStyle:MyUIButtonStyleRight andImgName:@"rl1Btn1.png" andRvc:self];
    [self.view addSubview:btnMap];
    MyUIButton* btnPolicy = [[L1Button alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y+FRAME_RSide_ToolBar_H, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andPagePolicy:[[DiscountPagePolicy alloc] initWithSubType:@""] andTitle:@"优惠政策" andStyle:MyUIButtonStyleRight andImgName:@"rl1Btn2.png" andRvc:self];
    [self.view addSubview:btnPolicy];
    MyUIButton* btnShoppingCart = [[L1Button alloc]initAll:CGRectMake(FRAME_RSide_ToolBar_First_X, FRAME_RSide_ToolBar_Frist_Y+FRAME_RSide_ToolBar_H*2, FRAME_RSide_ToolBar_W, FRAME_RSide_ToolBar_H) andPagePolicy:[[ShoppingCartPagePolicy alloc] initWithSubType:@""] andTitle:@"购物车" andStyle:MyUIButtonStyleRight andImgName:@"rl1Btn3.png" andRvc:self];
    [self.view addSubview:btnShoppingCart];
    
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(670, 86, 200, 25)];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.searchTextField setHidden:YES];
    [self.view addSubview:self.searchTextField];
    
    
    self.btnOpBack = [[UIButton alloc]initWithFrame:CGRectMake(10, 390, 36, 34)];
    [self.btnOpBack setImage:[UIImage imageNamed:@"btnBack.png"] forState:UIControlStateNormal];
    [self.btnOpBack addTarget:self action:@selector(opBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnOpBack];
    
    self.btnOpForward = [[UIButton alloc]initWithFrame:CGRectMake(980, 390, 35, 35)];
    [self.btnOpForward setImage:[UIImage imageNamed:@"btnForward.png"] forState:UIControlStateNormal];
    [self.btnOpForward addTarget:self action:@selector(opForward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnOpForward];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchTextField resignFirstResponder];
    [self setPagePolicy:[[SearchPagePolicy alloc] initWithSubType:self.searchTextField.text]];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //[self setVcType:ViewControllerProduct andSubType:((ProductType*)[DataAdapter shareInstance].productTypes[0]).productType];
    //[self.view bringSubviewToFront:self.l1Btns[0]];
    
    
    
}

//屏蔽page边的单击翻页事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        return NO;
        CGPoint touchPoint = [touch locationInView:self.view];
        
        if (touchPoint.x < 150 || touchPoint.x > 1024 - 150)
        {
            return NO;
        }
    }
    return YES;
}

- (void)setPagePolicy:(BasePagePolicy*)pagePolicy
{
    [self.modelController setPagePolicy:pagePolicy];
    UIViewController* vc1 = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    UIViewController* vc2 = [self.modelController viewControllerAtIndex:1 storyboard:self.storyboard];
    [self.pageViewController setViewControllers:@[vc1, vc2] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished)
     {
     }];
}
- (BasePagePolicy*)pagePolicy
{
    return [self.modelController pagePolicy];
}


- (void)setPage:(NSInteger)leftPageIndex animated:(BOOL)animated
{
    UIViewController* vc1 = [self.modelController viewControllerAtIndex:leftPageIndex storyboard:self.storyboard];
    UIViewController* vc2 = [self.modelController viewControllerAtIndex:leftPageIndex+1 storyboard:self.storyboard];
    [self.pageViewController setViewControllers:@[vc1, vc2] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:^(BOOL finished)
     {
     }];
}

- (UIViewController*)page:(NSInteger)index
{
    return [self.modelController viewControllerAtIndex:index storyboard:self.storyboard];
}

- (void)opMark:(OperationNode *)op
{
    if (self.opIndex >= 0)
    {
        OperationNode* current = [self.opArray objectAtIndex:self.opIndex];
        if (current.idTag != op.idTag && ![current.pagePolicy isEqual:op.pagePolicy])
        {
            self.opIndex ++;
            [self.opArray setObject:op atIndexedSubscript:self.opIndex];
        }
    }
    else
    {
        self.opIndex ++;
        [self.opArray setObject:op atIndexedSubscript:self.opIndex];
    }
}

- (void)opBack
{
    if (self.opIndex < 1)
    {
        //doNothing
    }
    else
    {
        OperationNode* on = [self.opArray objectAtIndex:self.opIndex -1];
        //[self setPagePolicy:on.pagePolicy];
        //[self setPage:on.pageIndex animated:YES];
        MyUIButton* btn = (MyUIButton*)[self.view viewWithTag:on.idTag];
        [btn onTouchUp:self];
        self.opIndex --;
    }
}

- (void)opForward
{
    if (self.opIndex >= [self.opArray count] -1)
    {
        //doNothing
    }
    else
    {
        OperationNode* on = [self.opArray objectAtIndex:self.opIndex +1];
        MyUIButton* btn = (MyUIButton*)[self.view viewWithTag:on.idTag];
        [btn onTouchUp:self];
        self.opIndex ++;
    }
}

- (IBAction)sync:(id)sender
{
    if (!authController.isAlreadAuth) {

    KPConsumer *consumer = [[KPConsumer alloc] initWithKey:@"xcInFxiv9tnMmS5a" secret:@"D7JvQn0wTR5rP9D9"];
    authController = [[KPAuthController alloc] initWithConsumer:consumer];
    //进行present页面
    [self presentViewController:authController animated:YES completion:NULL];
    }
    else
    {
        
        //[self doCreateFolder:@"YourHairSaion/DB/"];
        //[self doCreateFolder:@"YourHairSaion/IMG/Product/"];
        for (int i = 0; i < 10; i ++)
        {
            NSString* localFile = [[DataAdapter shareInstance]ImageLinkAtIndex:arc4random()%30 andType:PRODUCT_PIC_TYPE_FULL];
            NSString* remoteFile = [NSString stringWithFormat:@"%@%@", PATH_IMG_DIR, [localFile lastPathComponent]];
            NSLog(@"%@",remoteFile);
            [self doUploadFile:localFile andRemotePath:remoteFile];
            [self doDownloadFile:remoteFile andRemotePath:nil];
        }
        


        //[self doDownloadFile:self];
    }
}

@end
