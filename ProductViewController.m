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
- (void)imageViewDidStop:(NSString *)paraAnimationId finished:(NSString *)paraFinished context:(void *)paraContext;
- (void)doAnimationMoveToShoppingCart:(PSBroView*)cell;
@end

@implementation ProductViewController
/*
- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
}

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
    
    
    self.pc = [[UIPageControl alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.pc];

    [self loadFooter];
    [self loadDataSource];
   // [self setupNavBar];

}
*/


- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    int count = [dataAdapter  count];
    for (int i = self.fromIndex; i <= self.toIndex; i++)
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

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return self.toIndex - self.fromIndex + 1;//[self.items count];
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

    [super collectionView:collectionView didSelectView:view atIndex:index];
    if ([self canBuy:view])
    {
        [self prepareToBuy:view];
    }
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
/*
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
*/
/*
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
*/

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
