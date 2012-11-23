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

@interface ImgFullViewController ()
@property (nonatomic, assign)NSUInteger totalPage;
- (void)loadImg;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.totalPage = 0;
        
    self.lastPage = 0;
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
	
		((MyScrollView *)[self.mainScrollView viewWithTag:100+lastPage+1]).zoomScale = 1.0;
        ((MyScrollView *)[self.mainScrollView viewWithTag:100+lastPage-1]).zoomScale = 1.0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadImg];
    
}

- (void)loadImg
{
    DataAdapter* da = [DataAdapter shareInstance];
    int count = [da count];
    self.totalPage = count;
    self.mainScrollView.contentSize = CGSizeMake(1024*count, 480);
    for (int i = 0; i < count; i ++)
    {
            MyScrollView *ascrView = [[MyScrollView alloc] initWithFrame:CGRectMake(1024*i, 0, 1024, 748)];
            NSString *imgPath = [da ImageLinkAtIndex:i andType:PRODUCT_PIC_TYPE_FULL];
            ascrView.image = [UIImage imageWithContentsOfFile:imgPath];
            ascrView.tag = 100+i;
            [self.mainScrollView addSubview:ascrView];
    }
}
@end
