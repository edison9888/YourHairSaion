//
//  DetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DetailViewController.h"
//#import "MyToolBar.h"
#import "ProductViewController.h"
#import "RootViewController.h"
#import "ImgFullViewController.h"
#import "StatementViewController.h"


#define FRAME_Detail_IMG_X 0
#define FRAME_Detail_IMG_Y 0
#define FRAME_Detail_IMG_W 180
#define FRAME_Detail_IMG_H 230
#define FRAME_NAV_BAR_H 40

#define TAB_BAR_W 50

@interface DetailViewController ()
- (void)configView;
//@property (nonatomic, retain)MyToolBar* toolBar;
@property (nonatomic, retain)DetailView* detailView;
@property (nonatomic, strong)NSString* currentProductId;
//- (void)scaleToolbarItem;

- (void)showStatement;
@end

@implementation DetailViewController
@synthesize detailView = _detailView;
@synthesize currentProductId;
//@synthesize toolBar = _toolBar;

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
    [self configView];
}

- (void)viewDidUnload
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super viewWillAppear:animated];
    NSLog(@"DetailFrame!!!x=%f, y=%f, w=%f, h=%f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    
}

- (void)configView
{    
    self.detailView = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, FRAME_W, FRAME_H)];
    self.detailView.delegate = self;
    [self.view addSubview:self.detailView];
    
//    self.toolBar = [[MyToolBar alloc]initWithFrame:CGRectMake(FRAME_W-50 , FRAME_H - 50, 50, 50)];
 //   self.toolBar.barStyle = UIBarStyleBlackTranslucent;
 
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.center = self.view.center;
    [btn setTitle:@"Statement" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showStatement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
 //   [self.toolBar setItems:items animated:YES];
  //  [self.view addSubview:self.toolBar];
}


- (void)setItem:(PsDataItem *)dataItem {
    [super setItem:dataItem];
    [self.detailView fillData:(ProductShowingDetail*)dataItem];
}

//- (void)addProduct2Buy:(id)sender
//{
//    [[DataAdapter shareInstance]addProductToBuy:self.currentProductId];
//   // [self scaleToolbarItem];
//    /*
//    NGTabBarController* leftTabBarController = self.rootViewController.leftTabBarController;
//    if (leftTabBarController.selectedIndex == LeftTabBarViewControllerShoppingCart)
//    {
//        UINavigationController* nav = leftTabBarController.viewControllers[LeftTabBarViewControllerShoppingCart];
//        [((ShoppingCartViewController*)nav.topViewController) refresh];
//    }
//     */
//}
/*
- (void)scaleToolbarItem
{
    UIBarButtonItem* item = self.toolBar.items[0];
    if ([[DataAdapter shareInstance] productIsInShoppingCart:self.currentProductId])
    {
        item.title = @"TakeOut";
    }
    else
    {
        item.title = @"BUY";
    }
}
 */

- (void)ViewOnTouch:(UIScrollView *)view andData:(ProductShowingDetail *)psd
{
    self.psViewController.rootViewController.navigationController.navigationBarHidden = NO;
    [self.psViewController.rootViewController.imgFullViewController setData:psd];
    [self.psViewController.rootViewController.navigationController pushViewController:self.psViewController.rootViewController.imgFullViewController animated:YES];
}

- (void)showStatement
{
    [self.psViewController.rootViewController.statementViewController setProductViewController:self.psViewController andIndex:[self.psViewController indexInPage]];
    [self.psViewController.rootViewController.navigationController pushViewController:self.psViewController.rootViewController.statementViewController animated:YES];
    self.psViewController.rootViewController.navigationController.navigationBarHidden = NO;

}
@end
