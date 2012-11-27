//
//  PSViewController.m
//  BroBoard
//
//  Created by Peter Shih on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//





#import "ProductViewController.h"
#import "PSBroView.h"
#import "ProductShowingDetail.h"
#import "DataAdapter.h"
#import "DetailViewController.h"
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>



/**
 This is an example of a controller that uses PSCollectionView
 */

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

@interface ProductViewController ()
{
    int fromIndex;
    int toIndex;
}
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) UIColor* selectedColor;
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIImageView* buttomImageView;


- (void)restoreSelected:(PSCollectionView *)collectionView;
- (void)setupNavBar;
- (void)filterByType:(id)sender;
- (void)loadFooter;
- (void)imageViewDidStop:(NSString *)paraAnimationId finished:(NSString *)paraFinished context:(void *)paraContext;
- (void)doAnimationMoveToShoppingCart:(PSBroView*)cell;
@end

@implementation ProductViewController

@synthesize
items = _items,
collectionView = _collectionView;
@synthesize lastSelectedIndex;
@synthesize selectedColor;
@synthesize rootViewController, labelTitle, buttomImageView, detailViewController, pageCount;

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
/*
- (void)dealloc {
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
    self.items = nil;
    
    [super dealloc];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    //NSLog(@"x=%f, y=%f, w=%f, h=%f", FRAME_Content_X, FRAME_Content_Y, FRAME_Content_Label_W, FRAME_Content_Label_H);
    NSLog(@"x=%f, y=%f, w=%f, h=%f", FRAME_Content_CollectView_X, FRAME_Content_CollectView_Y, FRAME_Content_CollectView_W, FRAME_Content_CollectView_H);
    //NSLog(@"x=%f, y=%f, w=%f, h=%f", FRAME_Buttom_X, FRAME_Buttom_Y, FRAME_Buttom_W, FRAME_Buttom_H);
    self.view.backgroundColor = [UIColor blueColor];
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(FRAME_Content_X, FRAME_Content_Y, FRAME_Content_Label_W, FRAME_Content_Label_H)];
    self.labelTitle.text = @"女士 - 短发";
    self.labelTitle.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.labelTitle];
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(FRAME_Content_CollectView_X, FRAME_Content_CollectView_Y, 500-124+FRAME_Content_Label_W, 768-392+518)];
    //self.collectionView = [[PSCollectionView alloc] initWithFrame:self.view.bounds];
    self.collectionView.alwaysBounceHorizontal = NO;
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
   // [self setupNavBar];

}

- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    int count = [dataAdapter  count];
    for (int i = fromIndex; i <= toIndex; i++)
    {
        ProductShowingDetail* item = [ProductShowingDetail initByIndex:i];
        [self.items addObject:item];
    }
    [self dataSourceDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super viewWillAppear:animated];
    NSLog(@"ProductFrame!!!x=%f, y=%f, w=%f, h=%f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);

}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return toIndex - fromIndex + 1;//[self.items count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    PSBroView *v = (PSBroView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[PSBroView alloc] initWithFrame:CGRectZero];
    }
    v.productBuyingDelegate = self;
    [v fillViewWithObject:item];
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [PSBroView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {

    [self restoreSelected:collectionView];
    [view setBackgroundColor:selectedColor];
    self.lastSelectedIndex = index;
    if ([self canBuy:view])
    {
        [self prepareToBuy:view];
    }
    //NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    //UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    ProductShowingDetail* is = [self.items objectAtIndex:index];
    //nav1.title = is.productName;
    [self.detailViewController fillData:is];
    //[self.detailViewController.view drawRect:self.detailViewController.view.frame];
}

- (void)restoreSelected:(PSCollectionView *)collectionView
{
    
    for (UIView* cell in collectionView.subviews)
    {
        if ([cell isKindOfClass:[PSBroView class]])
        {
            if (![((PSBroView*)cell).backgroundColor isEqual:[UIColor whiteColor]])
            {
                [((PSBroView*)cell) setBackgroundColor:[UIColor whiteColor]];
                [((PSBroView*)cell) finishToBuy];
            }
        }
    }
    
    /*
    PSBroView* cell = [self collectionView:self.collectionView viewAtIndex:self.lastSelectedIndex];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell finishToBuy];
     */
    
}

- (void)setupNavBar
{
    NSMutableArray* leftBarItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    UIBarButtonItem* itemAll = [[UIBarButtonItem alloc]initWithTitle:@"所有" style:UIBarButtonItemStylePlain target:self action:@selector(filterByType:)];
    itemAll.tag = -1;
    [leftBarItems addObject:itemAll];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    NSLog(@"productType count=%d", [dataAdapter.productTypes count]);
    int count = 0;
    for (ProductType* productType in dataAdapter.productTypes)
    {
        UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:productType.typeName style:UIBarButtonItemStylePlain target:self action:@selector(filterByType:)];
        item.tag = count++;
        [leftBarItems addObject:item];
    }
    NSLog(@"itemcount=%d", [leftBarItems count]);
    //self.navigationItem.rightBarButtonItems = leftBarItems;
    self.navigationItem.leftBarButtonItems = leftBarItems;
    /*UIToolbar *mycustomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,320.0f, 44.0f)];
    //mycustomToolBar.center = CGPointMake(160.0f,200.0f);
    mycustomToolBar.barStyle = UIBarStyleBlackTranslucent;
    [mycustomToolBar setItems:leftBarItems animated:YES];
    [mycustomToolBar sizeToFit];
    [self.view addSubview:mycustomToolBar];*/
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (id)initProductViewControllerFromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(DetailViewController*)detailViewController
{
    self = [super init];
    if (self) {
        fromIndex = beginIndex;
        toIndex = endIndex;
        self.items = [NSMutableArray arrayWithCapacity:(endIndex - beginIndex + 1)];
        self.detailViewController = detailViewController;
    }
    return self;
}

- (NSUInteger)indexInPage
{
    if (toIndex < 0)
    {
        return 0;
    }
    int index = (toIndex + 1) / ITEMS_PER_PAGE;
    if (index*ITEMS_PER_PAGE <= toIndex)
    {
        return index * 2;
    }
    else
    {
        return (index - 1)*2;
    }
}

- (void)setPageCount:(NSUInteger)count
{
    pageCount = count;
    [self loadFooter];
    
}

- (void)loadFooter
{
    int currentPage = [self indexInPage] / 2;

    UIPageControl *pc = [[UIPageControl alloc]initWithFrame:CGRectMake(FRAME_Buttom_X , FRAME_Buttom_Y, FRAME_Buttom_W+300, FRAME_Buttom_H)];
    pc.numberOfPages = self.pageCount;
    pc.currentPage = currentPage;
    pc.backgroundColor = [UIColor blueColor];
    //pc.center = CGPointMake(self.view.center.x, FRAME_Buttom_Y);
    //NSLog(@"center x[%f], y[%f]", (FRAME_Buttom_W+FRAME_Buttom_X)/2, FRAME_Buttom_Y);
    [self.view addSubview:pc];
    [self.view setNeedsDisplay];
}


- (BOOL)canBuy:(PSCollectionViewCell *)cell
{
    return YES;
}
- (void)prepareToBuy:(PSCollectionViewCell *)cell
{
    [((PSBroView*)cell) prepareToBuy];
}
- (void)productAdd:(PSCollectionViewCell *)cell
{
    [[DataAdapter shareInstance]addProductToBuy:((ProductShowingDetail*)((PSBroView*)cell).object).productId];
    [((PSBroView*)cell) productAdd];
    
    [self doAnimationMoveToShoppingCart:(PSBroView*)cell];
    
}
- (void)productReduct:(PSCollectionViewCell *)cell
{
    if ([[DataAdapter shareInstance] numInShoppingCart:((ProductShowingDetail*)((PSBroView*)cell).object).productId] > 0)
    {
    
        [[DataAdapter shareInstance]reduceProductToBuy:((ProductShowingDetail*)((PSBroView*)cell).object).productId];
        [((PSBroView*)cell) productReduct];
    }
    
}
- (void)finishToBuy:(PSCollectionViewCell *)cell
{
    [((PSBroView*)cell) prepareToBuy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView* cell in self.collectionView.subviews)
    {
        if ([cell isKindOfClass:[PSBroView class]])
        {
            [((PSBroView*)cell) reflash];
        }
    }
}

- (void)reloadData
{
    [self loadDataSource];
}

- (void)setRangWithFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    fromIndex = from;
    toIndex = to;
}

- (void)imageViewDidStop:(NSString *)paraAnimationId finished:(NSString *)paraFinished context:(void *)paraContext
{
    [((__bridge UIImageView*)paraContext) removeFromSuperview];
}

- (void)doAnimationMoveToShoppingCart:(PSBroView *)cell
{    
    UIImageView* tmp = [cell imageViewCopy];
    [self.rootViewController.view addSubview:tmp];
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:1]; //动画时长
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:tmp cache:YES];
    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    tmp.frame = CGRectMake(900, 600, tmp.frame.size.width, tmp.frame.size.width);
    tmp.alpha = 0;
    tmp.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView commitAnimations];
}
@end
