//
//  MapPsViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-24.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsViewController.h"
#import "PsItemView.h"
#import "DataAdapter.h"
#import "RootViewController.h"
#import "PsDetailViewController.h"

@interface PsViewController ()

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) UIColor* selectedColor;
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) NSString* titleStr;


- (void)restoreSelected:(PSCollectionView *)collectionView;
- (void)setupNavBar;
- (void)filterByType:(id)sender;
- (void)loadFooter;

@end

@implementation PsViewController

@synthesize
items = _items,
collectionView = _collectionView;
@synthesize lastSelectedIndex;
@synthesize selectedColor;
@synthesize rootViewController, labelTitle, detailViewController, pageCount, titleStr, fromIndex, toIndex;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (id)initProductViewControllerWithTitle:(NSString*)title fromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(DetailViewController*)detailViewController
{
    self = [super init];
    if (self) {
        self.fromIndex = beginIndex;
        self.toIndex = endIndex;
        titleStr = title;
        self.items = [NSMutableArray arrayWithCapacity:(endIndex - beginIndex + 1)];
        self.detailViewController = detailViewController;
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
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor blueColor];
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(FRAME_Content_X, FRAME_Content_Y, FRAME_Content_Label_W, FRAME_Content_Label_H)];
    self.labelTitle.text = titleStr;
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
    
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 2;
    
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = UITextAlignmentCenter;
    self.collectionView.loadingView = loadingLabel;
    self.lastSelectedIndex = 0;
    self.selectedColor = [UIColor colorWithRed:0.65098041296005249 green:0.90196084976196289 blue:0.92549026012420654 alpha:1];
    [self loadDataSource];
    
}

- (void)loadDataSource {
    [self.items removeAllObjects];
    //need to be implement
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
    return toIndex - fromIndex + 1;//[self.items count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    PsItemView *v = (PsItemView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[PsItemView alloc] initWithFrame:CGRectZero];
    }
    [v fillViewWithObject:item];
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [PsItemView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    
    [self restoreSelected:collectionView];
    [view setBackgroundColor:selectedColor];
    self.lastSelectedIndex = index;
    //NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    //UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    //nav1.title = is.productName;
    [self.detailViewController setItem:[self.items objectAtIndex:index]];
    //[self.detailViewController.view drawRect:self.detailViewController.view.frame];
}

- (void)restoreSelected:(PSCollectionView *)collectionView
{
    
    for (UIView* cell in collectionView.subviews)
    {
        if ([cell isKindOfClass:[PsItemView class]])
        {
            if (![((PsItemView*)cell).backgroundColor isEqual:[UIColor whiteColor]])
            {
                [((PsItemView*)cell) setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
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
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
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
    [self.view addSubview:pc];
    [self.view setNeedsDisplay];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
@end
