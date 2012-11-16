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

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) UIColor* selectedColor;

- (void)restoreSelected:(PSCollectionView *)collectionView;
- (void)setupNavBar;
- (void)filterByType:(id)sender;

@end

@implementation ProductViewController

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
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (isDeviceIPad()) {
        self.collectionView.numColsPortrait = 3;
        self.collectionView.numColsLandscape = 3;
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
    // Request
    /*
    NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
    NSURL *URL = [NSURL URLWithString:URLPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (!error && responseCode == 200) {
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (res && [res isKindOfClass:[NSDictionary class]]) {
                self.items = [res objectForKey:@"data"];
                [self dataSourceDidLoad];
            } else {
                [self dataSourceDidError];
            }
        } else {
            [self dataSourceDidError];
        }
    }];
     */
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    int count = [dataAdapter  count];
    for (int i = 0; i < count; i++)
    {
        ProductShowingDetail* item = [ProductShowingDetail initByIndex:i];
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

    [self restoreSelected:collectionView];
    view.backgroundColor = self.selectedColor;
    self.lastSelectedIndex = index;
    NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    DetailViewController* detailVC =  (DetailViewController*)nav1.topViewController;
    ProductShowingDetail* is = [self.items objectAtIndex:index];
    nav1.title = is.productName;
    [detailVC fillData:is];
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
@end
