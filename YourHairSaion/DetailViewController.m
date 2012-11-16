//
//  DetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "MyToolBar.h"
#import "ShoppingCartViewController.h"

#define FRAME_REAL_X 512
#define FRAME_REAL_Y 20
#define FRAME_REAL_W 512
#define FRAME_REAL_H 748
#define FRAME_NAV_BAR_H 40

#define TAB_BAR_W 50

@interface DetailViewController ()
- (void)configView;
@property (nonatomic, retain)MyToolBar* toolBar;
@property (nonatomic, retain)DetailView* detailView;
@property (nonatomic, strong)NSString* currentProductId;
- (void)scaleToolbarItem;
@end

@implementation DetailViewController
@synthesize detailView = _detailView;
@synthesize currentProductId;
@synthesize toolBar = _toolBar;
@synthesize rootViewController;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    
    [UIView commitAnimations];
    self.detailView = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, FRAME_REAL_W - TAB_BAR_W, FRAME_REAL_H - FRAME_NAV_BAR_H)];
    [self.view addSubview:self.detailView];
    
    self.toolBar = [[MyToolBar alloc]initWithFrame:CGRectMake(512-50-80 , 650, 50, 50)];
    self.toolBar.barStyle = UIBarStyleBlackTranslucent;
 
    UIBarButtonItem *buyItem = [[UIBarButtonItem alloc]initWithTitle:@"BUY" style:UIBarButtonSystemItemBookmarks target:self action:@selector(addProduct2Buy:)];
    NSMutableArray* items = [[NSMutableArray alloc]initWithObjects:buyItem, nil];
    [self.toolBar setItems:items animated:YES];
    [self.view addSubview:self.toolBar];
    


}

- (void)fillData:(ProductShowingDetail *)psd
{
    self.navigationItem.title = psd.productName;
    [self.detailView fillData:psd];
    self.currentProductId = psd.productId;
    [self scaleToolbarItem];
}

- (void)addProduct2Buy:(id)sender
{
    [[DataAdapter shareInstance]addProductToBuy:self.currentProductId];
    [self scaleToolbarItem];
    NGTabBarController* leftTabBarController = self.rootViewController.leftTabBarController;
    if (leftTabBarController.selectedIndex == LeftTabBarViewControllerShoppingCart)
    {
        UINavigationController* nav = leftTabBarController.viewControllers[LeftTabBarViewControllerShoppingCart];
        [((ShoppingCartViewController*)nav.topViewController) refresh];
    }
}

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
@end
