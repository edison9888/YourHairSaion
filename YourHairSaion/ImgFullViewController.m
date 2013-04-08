//
//  ImgFullViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-21.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ImgFullViewController.h"
#import "MyScrollView.h"
#import "DataAdapter.h"
#import "ProductShowingDetail.h"

@interface ImgFullViewController ()
@property (nonatomic, assign)NSUInteger totalPage;
@property (nonatomic, strong)NSMutableDictionary* imageDic;
@property (nonatomic, strong)NSString* currentFilter;
@property (nonatomic, assign)BOOL filterChanged;
- (void)loadImg:(NSUInteger)index;
- (void)loadImgNearBy;

@end

@implementation ImgFullViewController
@synthesize lastPage, mainScrollView, totalPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (ImgFullViewController*)initWithObject:(ProductShowingDetail *)psd
{
    self = [super init];
    if (self)
    {
        self.lastPage = psd.index;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.imageDic = [[NSMutableDictionary alloc]init];
    self.currentFilter = [[DataAdapter shareInstance]currentFilter];
    self.filterChanged = NO;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.x > 0)
    {
        //targetContentOffset->x += 1024;
        lastPage += 1;
    }
    else
    {
        //targetContentOffset->x -= 1024;
        lastPage -= 1;
    }
    if (self.lastPage < 0)
    {
        self.lastPage = 0;
    }
    else if (self.lastPage >= self.totalPage)
    {
        self.lastPage = self.totalPage - 1;
    }
    targetContentOffset->x = lastPage * 1024;
    [self loadImgNearBy];
    
}
#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
//ScrollView 划动的动画结束后调用.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"off x[%f],y[%f]", scrollView.contentOffset.x, scrollView.contentOffset.y);
    [scrollView setContentOffset:CGPointMake(lastPage*1024, 0) animated:NO];

//	CGFloat pageWidth = scrollView.frame.size.width;
//	NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	//NSLog(@"page = %d, lastPage = %d", page, lastPage);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DataAdapter* da = [DataAdapter shareInstance];
    int count = [da count];
    self.totalPage = count;
    self.mainScrollView.contentSize = CGSizeMake(1024*count, 480);
    if (self.filterChanged)
    {
        NSArray* views = [self.imageDic allValues];
        for (UIView* view in views)
        {
            [view removeFromSuperview];
        }
    }
    [self loadImgNearBy];
    [self.mainScrollView setContentOffset:CGPointMake(self.lastPage*1024, 0) animated:NO];
}

- (void)loadImg:(NSUInteger)index
{
    DataAdapter* da = [DataAdapter shareInstance];
    if (0 > index || index >= [da count])
    {
        return;
    }
    NSString *key = [da ProductIdAtIndex:index];
    MyScrollView *ascrView = [self.imageDic objectForKey:key];
    if (nil == ascrView)
    {
        ascrView = [[MyScrollView alloc] initWithFrame:CGRectMake(1024*index, 0, 1024, 748)];
        NSString *imgPath = [da ImageLinkAtIndex:index andType:PRODUCT_PIC_TYPE_FULL];
        ascrView.image = [UIImage imageWithContentsOfFile:imgPath];
        ascrView.tag = 100+index;
        [self.mainScrollView addSubview:ascrView];
        [self.imageDic setObject:ascrView forKey:key];
    }
    else
    {
        if (self.filterChanged && ![self.mainScrollView.subviews containsObject:ascrView])
        {
            ascrView.frame = CGRectMake(1024*index, 0, 1024, 748);
            [self.mainScrollView addSubview:ascrView];
        }
        ((MyScrollView *)[self.mainScrollView viewWithTag:100+index]).zoomScale = 1.0;
    }
}

- (void)loadImgNearBy
{
    [self loadImg:self.lastPage];
    if (self.lastPage >= self.totalPage)
    {
        [self loadImg:self.lastPage - 1];
    }
    else if (self.lastPage <= 0)
    {
        [self loadImg:self.lastPage + 1];
    }
    else
    {
        [self loadImg:self.lastPage - 1];
        [self loadImg:self.lastPage + 1];
    }
}


- (void)setData:(ProductShowingDetail *)psd
{
    self.lastPage = psd.index;
    NSString* currentFilter = [[DataAdapter shareInstance] currentFilter];
    if (![self.currentFilter isEqualToString:currentFilter])
    {
        self.currentFilter = currentFilter;
        self.filterChanged = YES;
    }
    else
    {
        self.filterChanged = NO;
        
    }
}
@end
