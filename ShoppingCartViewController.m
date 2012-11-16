//
//  ShoppingCartViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-13.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "PSBroView.h"
#import "ProductShowingDetail.h"
#import "DataAdapter.h"
#import "DetailViewController.h"


/**
 Detect iPad
 */
static BOOL isDeviceIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
#endif
    return NO;
}


@interface ShoppingCartViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) UIColor* selectedColor;

- (void)restoreSelected:(PSCollectionView *)collectionView;
- (void)setupNavBar;
- (void)filterByType:(id)sender;
- (void)payOff:(id)sender;

@end

@implementation ShoppingCartViewController

@synthesize
items = _items,
collectionView = _collectionView;
@synthesize lastSelectedIndex;
@synthesize selectedColor;
@synthesize rootview;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (isDeviceIPad()) {
        self.collectionView.numColsPortrait = 2;
        self.collectionView.numColsLandscape = 2;
    } else {
        self.collectionView.numColsPortrait = 2;
        self.collectionView.numColsLandscape = 3;
    }
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = UITextAlignmentCenter;
    self.collectionView.loadingView = loadingLabel;
    self.lastSelectedIndex = 0;
    self.selectedColor = [UIColor colorWithRed:0.65098041296005249 green:0.90196084976196289 blue:0.92549026012420654 alpha:1];
    [self loadDataSource];
    [self setupNavBar];
    
}

- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    int count = [dataAdapter.productsToBuy count];
    NSArray* products = [dataAdapter.productsToBuy allValues];
    for (int i = 0; i < count; i++)
    {
        ProductShowingDetail* item = [ProductShowingDetail initByProductBase:products[i]];
        [self.items addObject:item];
    }
    [self dataSourceDidLoad];
    
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    PSBroView *v = (PSBroView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[PSBroView alloc] initWithFrame:CGRectZero];
    }
    
    [v fillViewWithObject:item];
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [PSBroView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    //    NSDictionary *item = [self.items objectAtIndex:index];
    //self.parentViewController
    // You can do something when the user taps on a collectionViewCell here
    //PSCollectionViewCell* lastSelectView = collectionView.subviews[self.lastSelectedIndex];
    //lastSelectView.backgroundColor = [UIColor whiteColor];
    [self restoreSelected:collectionView];
    view.backgroundColor = self.selectedColor;
    self.lastSelectedIndex = index;
    NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    DetailViewController* detailVC =  (DetailViewController*)nav1.topViewController;
    ProductShowingDetail* is = [self.items objectAtIndex:index];
    nav1.title = is.productName;
    [detailVC fillData:is];
    for (UIView* v in detailVC.view.subviews)
    {
        if ([v isKindOfClass:[UIImageView class]])
        {
            
            ((UIImageView*)v).image = [UIImage imageNamed:is.fullFileName];
        }
        if ([v isKindOfClass:[UILabel class]])
        {
            ((UILabel*)v).text = is.productDetail;
        }
    }
    
    //UIImageView* imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:is.fullFileName]];
    //[detailVC.view addSubview:imgV];
    //[detailVC updateViewConstraints];
    //   [imgV drawRect:imgV.frame];
    //[detailVC doSomething];
    [nav1.view drawRect:nav1.view.frame];
}

- (void)restoreSelected:(PSCollectionView *)collectionView
{
    for (PSCollectionViewCell* cell in collectionView.subviews)
    {
        if (![cell.backgroundColor isEqual:[UIColor whiteColor]])
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setupNavBar
{
    UIBarButtonItem* itemPayOff = [[UIBarButtonItem alloc]initWithTitle:@"结算" style:UIBarButtonItemStylePlain target:self action:@selector(payOff:)];
    
    self.navigationItem.rightBarButtonItem = itemPayOff;
}

- (void)filterByType:(id)sender
{
    UIBarButtonItem* item = sender;
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    if (item.tag < 0)
    {
        [dataAdapter setFilter:nil];
    }
    else
    {
        ProductType* productType = dataAdapter.productTypes[item.tag];
        NSLog(@"set filter----%@", productType.typeName);
        [dataAdapter setFilter:productType];
        
    }
    [self loadDataSource];
    [self restoreSelected:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadDataSource];
}
- (void)payOff:(id)sender
{
    NSLog(@"go for pay off");
}

- (void)refresh
{
    [self loadDataSource];
}
@end
