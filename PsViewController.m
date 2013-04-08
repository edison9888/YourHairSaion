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
#import "PsDetailViewControllerBase.h"
#import "MyPageControl.h"
#import "PsView.h"
#import "TitleView.h"


@interface PsViewController ()

@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UILabel* labelPage;
@property (nonatomic, strong) NSString* titleStr;
@property (nonatomic, strong) MyPageControl* pc;
@property (nonatomic, strong)UIImageView* ivBg;


- (void)setupNavBar;
- (void)filterByType:(id)sender;
- (void)loadFooter;
- (PsItemView*)reusableCellForIndex:(NSInteger)index;

@end

@implementation PsViewController

@synthesize
items = _items,
collectionView = _collectionView;
@synthesize lastSelectedIndex;
@synthesize rootViewController, labelTitle, detailViewController, pageCount, titleStr, fromIndex, pc, toIndex;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (id)initProductViewControllerWithTitle:(NSString*)title fromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(PsDetailViewControllerBase*)dvc
{
    NSLog(@"%s", __FUNCTION__);

    self = [super init];
    if (self) {
        self.fromIndex = beginIndex;
        self.toIndex = endIndex;
        titleStr = title;
        self.items = [NSMutableArray arrayWithCapacity:(endIndex - beginIndex + 1)];
        self.detailViewController = dvc;
        //self.view = [[PsView alloc]init];;
    }
    return self;
}


- (void)viewDidUnload {
    NSLog(@"%s", __FUNCTION__);

    [super viewDidUnload];
    
    self.collectionView.delegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.collectionView = nil;
}
- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);

    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = nil;
    self.ivBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 478, 698)];
    self.ivBg.image = [UIImage imageNamed:@"paper_left.png"];
    self.ivBg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:self.ivBg atIndex:0];
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(FRAME_Content_Label_X, FRAME_Content_Label_Y, FRAME_Content_Label_W, FRAME_Content_Label_H)];
    self.labelTitle.text = titleStr;
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.textColor = [UIColor blueColor];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:22];
    //[self.view addSubview:self.labelTitle];
    
    TitleView* tv = [[TitleView alloc]initWithFrame:CGRectMake(FRAME_Content_Label_X, FRAME_Content_Label_Y, FRAME_Content_Label_W, FRAME_Content_Label_H)];
    [tv setTitleInCHS:titleStr andTitleInENG:@""];
    [self.view addSubview:tv];
    
    self.labelPage = [[UILabel alloc]initWithFrame:CGRectMake(FRAME_Buttom_X , FRAME_Buttom_Y + 10, 100, FRAME_Buttom_H)];

    self.labelPage.text = @"";
    self.labelPage.backgroundColor = [UIColor clearColor];
    self.labelPage.textColor = [UIColor darkGrayColor];
    self.labelPage.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:self.labelPage];
    
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(FRAME_Content_CollectView_X, FRAME_Content_CollectView_Y, 500-124+FRAME_Content_Label_W, 768-392+580)];
    //self.collectionView = [[PSCollectionView alloc] initWithFrame:self.view.bounds];
    self.collectionView.alwaysBounceHorizontal = NO;
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self setCollectionViewColum];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = UITextAlignmentCenter;
    self.collectionView.loadingView = loadingLabel;
    self.lastSelectedIndex = -1;
    
    self.pc = [[MyPageControl alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.pc];
    
    [self loadFooter];

    [self loadDataSource];

}

- (void)setCollectionViewColum
{
    self.collectionView.numColsPortrait = 3;
    self.collectionView.numColsLandscape = 3;

}
- (void)loadDataSource {
    NSLog(@"%s", __FUNCTION__);

    [self.items removeAllObjects];
    //need to be implement
    [self dataSourceDidLoad];
    
}

- (void)dataSourceDidLoad {
    NSLog(@"%s", __FUNCTION__);

    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    NSLog(@"%s", __FUNCTION__);

    [self.collectionView reloadData];
}

#pragma mark - PSCollectionViewDelegate and DataSource
- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    NSLog(@"%s", __FUNCTION__);

    return toIndex - fromIndex + 1;//[self.items count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    NSLog(@"%s", __FUNCTION__);

    
    return [self reusableCellForIndex:index];
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    NSLog(@"%s", __FUNCTION__);

    id item = [self.items objectAtIndex:index];
    
    return [PsItemView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    NSLog(@"%s", __FUNCTION__);

    [self restoreSelected:collectionView];
    PsItemView* cell = view;
    [cell setSelected:YES];
    self.lastSelectedIndex = index;
    //NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    //UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    //nav1.title = is.productName;
    [self.detailViewController setItem:[self.items objectAtIndex:index]];
    //[self.detailViewController.view drawRect:self.detailViewController.view.frame];
}

- (void)restoreSelected:(PSCollectionView *)collectionView
{    NSLog(@"%s", __FUNCTION__);

    /*
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
     */
PsItemView* cell = [self collectionView:self.collectionView viewAtIndex:self.lastSelectedIndex];
    [cell setSelected:NO];
}


//- (void)filterByType:(id)sender
//{
//    UIBarButtonItem* item = sender;
//    DataAdapter* dataAdapter = [DataAdapter shareInstance];
//    if (item.tag < 0)
//    {
//        [dataAdapter setFilter:nil];
//    }
//    else
//    {
//        ProductType* productType = dataAdapter.productTypes[item.tag];
//        NSLog(@"set filter----%@", productType.typeName);
//        [dataAdapter setFilter:productType];
//        
//    }
//    [self loadDataSource];
//    [self restoreSelected:self.collectionView];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    NSLog(@"%s", __FUNCTION__);

    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (NSUInteger)indexInPage
{
    NSLog(@"%s", __FUNCTION__);

    if (toIndex < 0)
    {
        return 0;
    }
    int index = (toIndex + 1) / [self.pagePolicy itemPerPage];
    if (index*[self.pagePolicy itemPerPage] <= toIndex)
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
    NSLog(@"%s", __FUNCTION__);

    pageCount = count;
    [self loadFooter];
    
}

- (void)loadFooter
{    NSLog(@"%s", __FUNCTION__);

    if (nil != self.pc)
    {
        if (pageCount > 1)
        {
            self.pc.hidden = NO;
            int currentPage = [self indexInPage] / 2;
            self.pc.numberOfPages = self.pageCount;
            self.pc.currentPage = currentPage;
            //self.pc.frame = CGRectMake(FRAME_Buttom_X , FRAME_Buttom_Y, FRAME_Buttom_W+300, FRAME_Buttom_H);
            self.pc.backgroundColor = [UIColor clearColor];
            self.pc.userInteractionEnabled = YES;
        }
        else
        {
            self.pc.hidden = YES;
        }
    }
}



- (void)viewWillAppear:(BOOL)animated
{    NSLog(@"%s", __FUNCTION__);

    [super viewWillAppear:animated];
//    if ([self numberOfViewsInCollectionView:self.collectionView] > 0 && self.lastSelectedIndex < 0)
//    {
//        self.lastSelectedIndex = 0;
//        [self collectionView:self.collectionView didSelectView:[self collectionView:self.collectionView viewAtIndex:0] atIndex:0];
//    }
    self.pc.frame = CGRectMake(FRAME_Buttom_X , FRAME_Buttom_Y, FRAME_Buttom_W + 350, FRAME_Buttom_H);
    self.pc.center = CGPointMake(self.view.center.x, self.pc.center.y);
    self.labelPage.text = [NSString stringWithFormat:@"- PAGE %d -", [self indexInPage] + 1];
}

- (void)reloadData
{    NSLog(@"%s", __FUNCTION__);

    [self loadDataSource];
}

- (void)setRangWithFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{    NSLog(@"%s", __FUNCTION__);

    fromIndex = from;
    toIndex = to;
    [self reloadData];
}

- (void)setTitleStr:(NSString *)title
{    NSLog(@"%s", __FUNCTION__);

    self.labelTitle.text = title;
}

- (void)viewDidAppear:(BOOL)animated
{    NSLog(@"%s", __FUNCTION__);

    [super viewDidAppear:animated];
    if ([self numberOfViewsInCollectionView:self.collectionView] > 0 && self.lastSelectedIndex < 0)
    {
        self.lastSelectedIndex = 0;
        [self collectionView:self.collectionView didSelectView:[self collectionView:self.collectionView viewAtIndex:0] atIndex:0];
    }

    NSLog(@"frame.x=%f, y=%f, w=%f, h=%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (PsItemView*)reusableCellForIndex:(NSInteger)index
{    NSLog(@"%s", __FUNCTION__);

    PsItemView* cell = [self.collectionView viewWithTag:TAG_PSVIEW_BASE+index];
    if (nil ==  cell)
    {
        
        cell = [self createNewItemViewWithIndex:index];
        //[reusableCell setObject:cell forKey:item.key];
    }
    
    return cell;
}
- (PsItemView*)createNewItemViewWithIndex:(NSInteger)index
{    NSLog(@"%s", __FUNCTION__);

    PsDataItem* item = [self.items objectAtIndex:index];

    PsItemView* cell = [[PsItemView alloc] initWithFrame:CGRectZero];
    [cell setTag:TAG_PSVIEW_BASE+index];
    [cell fillViewWithObject:item];
    return cell;
}

@end
