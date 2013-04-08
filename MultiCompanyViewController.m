//
//  MultiCompanyViewController.m
//  YourHairSaion
//
//  Created by chen loman on 13-3-6.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//
#define MARGIN 20
#import "MultiCompanyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SyncOperationManager.h"
#import "SyncProgressViewController.h"
#import "SyncPopUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"
#import "AppDelegate.h"
#import "DataAdapter.h"

#define IMG_W  170

#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS 5
#define ITEM_SPACING (IMG_W+200)
#define INCLUDE_PLACEHOLDERS NO

@interface MultiCompanyViewController ()
@property (nonatomic, strong)IBOutlet UIScrollView* svContent;
@property (nonatomic, strong)IBOutlet UILabel* labelCompanyName;
@property (nonatomic, assign)NSInteger lastSelected;
@property (nonatomic, strong)NSMutableArray* ivs;
@property (nonatomic, strong)IBOutlet UIButton* btnStart;


@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) BOOL isAuthing;
@property (nonatomic, assign) BOOL isSynced;

- (IBAction)onStart:(id)sender;


@end

@implementation MultiCompanyViewController
@synthesize wrap;
@synthesize items;
@synthesize carousel;

- (void)setUp
{
	//set up data
	wrap = YES;
    LCFileManager* fm = [LCFileManager shareInstance];
    NSString* path = [[[DataAdapter shareInstance]path] stringByAppendingString:@"/companies.plist"];
    NSLog(@"path=%@", [[NSBundle mainBundle]pathForResource:@"companies.plist" ofType:nil]);
    if (![fm checkSourPath:path error:nil])
    {
        if([fm copyFile:[[NSBundle mainBundle]pathForResource:@"companies.plist" ofType:nil] toDestPath:path overWrite:NO error:nil])
        {
            self.items = [NSArray arrayWithContentsOfFile:path];
        }
        else
        {
            self.items = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"companies.plist" ofType:nil]];
        }
    }
    else
    {
        self.items = [NSArray arrayWithContentsOfFile:path];
    }
    
    int count = [items count];
    if (count)
    {
        self.ivs = [NSMutableArray arrayWithCapacity:count];
    }
    self.isAuthing = NO;
    self.isSynced = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    carousel.decelerationRate = 0.5;
    carousel.type = iCarouselTypeCoverFlow2;
    
    
    self.lastSelected = -1;
    //    self.companies = [NSArray arrayWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"companies.plist"    ofType:nil]];
    //    //self.svContent.pagingEnabled = YES;
    //    self.svContent.showsHorizontalScrollIndicator = NO;
    //    self.svContent.showsVerticalScrollIndicator = NO;
    //
    //
    //    int count = [_companies count];
    //    if (count)
    //    {
    //        self.ivs = [NSMutableArray arrayWithCapacity:count];
    //    }
    //
    //
    //    self.svContent.contentSize = CGSizeMake((IMG_W+MARGIN) * count- MARGIN, IMG_W);
    //    for (int i = 0; i < count; i ++)
    //    {
    //        NSDictionary* companyInfo = [self.companies objectAtIndex:i];
    //        UIImageView* iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMG_W, IMG_W)];
    //        UITapGestureRecognizer* gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgOnTouch:)];
    //        gr.delegate = self;
    //        [gr setNumberOfTapsRequired:1];
    //        [iv addGestureRecognizer:gr];
    //        iv.userInteractionEnabled = YES;
    //        CGRect frame = iv.frame;
    //        iv.contentMode = UIViewContentModeScaleAspectFit;
    //        iv.image = [UIImage imageNamed:[companyInfo objectForKey:@"imgLink"]];
    //        iv.tag = i;
    //        frame.origin.x = (IMG_W+MARGIN) * i;
    //        frame.origin.y = 0;
    //        iv.frame = frame;
    //        [self.svContent addSubview:iv];
    //        [self.ivs addObject:iv];
    //    }
    
    //    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imgOnTouch:(id)target
{
    UITapGestureRecognizer* gr = target;
    if (self.lastSelected != -1)
    {
        [self img:[self.ivs objectAtIndex:self.lastSelected] setState:NO];
    }
    UIImageView* iv = gr.view;
    [self img:iv setState:YES];
    self.lastSelected = iv.tag;
    
}

- (void)img:(UIImageView*)iv setState:(BOOL)state
{
    if (iv)
    {
        if (state)
        {
            
            iv.layer.borderWidth = 5.0f;
            iv.layer.borderColor = COLOR_BLUE.CGColor;
            CGFloat mid = iv.frame.origin.x + iv.frame.size.width/2;
            CGFloat left = mid - self.svContent.frame.size.width/2;
            //[self.svContent scrollRectToVisible:CGRectMake(left, 0, self.svContent.frame.size.width, self.svContent.frame.size.height) animated:YES];
            //[self onLogin:nil];
        }
        else
        {
            iv.layer.borderWidth = 0.0f;
        }
    }
}

- (void)onStart:(id)sender
{
//    self.isSynced = YES;
//    [self viewDidHide:nil];
//    return ;
    SyncOperationManager* syncManager = [SyncOperationManager shareInstance];
    
    //    SyncMainViewController* vc = [[SyncMainViewController alloc]initWithNibName:@"SyncMainViewController" bundle:nil];
    
    //    [self.psViewController.rootViewController.view addSubview:vc.view];
    //    vc.view.frame =  CGRectMake(0, 0, 800, 600);
    if ([syncManager isAuthoried])
    {
        SyncProgressViewController* vc = [[SyncProgressViewController alloc]initWithNibName:@"SyncProgressViewController" bundle:nil];
        syncManager.processerDelege = vc;
        syncManager.resultDelege = self;
        //UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //nav.view.frame = CGRectMake(0, 0, 800, 600);
        //nav.navigationBarHidden = YES;
        //PopUpViewController* pop = [[PopUpViewController alloc]initWithNavContentViewController:nav];
        SyncPopUpViewController* pop = [[SyncPopUpViewController alloc]initWithContentViewController:vc];
        pop.popUpDeleage = self;
        [pop show:self.view andAnimated:YES];
        [syncManager doUpdate:sender];
        [pop show:self.view andAnimated:YES];
    }
    else
    {
        self.isAuthing = YES;
        [syncManager doAuthorizeInViewController:self];
        
    }
    //[self viewDidHide:nil];
    //[self syncSuccess:nil];
    
}







- (void)dealloc
{
	//it's a good idea to set these to nil here to avoid
	//sending messages to a deallocated viewcontroller
	carousel.delegate = nil;
	carousel.dataSource = nil;
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}




#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	//UILabel *label = nil;
	
	//create new view if no view is available for recycling
    NSDictionary* companyInfo = [self.items objectAtIndex:index];
	if (view == nil)
	{
        
        UIImageView* iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMG_W, IMG_W)];
        UITapGestureRecognizer* gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgOnTouch:)];
        gr.delegate = self;
        [gr setNumberOfTapsRequired:1];
        //[iv addGestureRecognizer:gr];
        iv.userInteractionEnabled = YES;
        CGRect frame = iv.frame;
        iv.image = [self imageWithName:[companyInfo objectForKey:@"imgLink"]];
        iv.contentMode = UIViewContentModeScaleToFill;
        iv.tag = index;
        view = iv;
        
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 5);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 4;
        //view.layer.shadowPath =  [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
        //        iv.frame = frame;
        //        [self.svContent addSubview:iv];
        [self.ivs addObject:iv];
        
        //		view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] autorelease];
        //		label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
        //		label.backgroundColor = [UIColor clearColor];
        //		label.textAlignment = UITextAlignmentCenter;
        //		label.font = [label.font fontWithSize:50];
        //		[view addSubview:label];
	}
	else
	{
		//label = [[view subviews] lastObject];
        UIImageView* iv = view;
        iv.image = [self imageWithName:[companyInfo objectForKey:@"imgLink"]];
        
	}
	
    //set label
	//label.text = [[items objectAtIndex:index] stringValue];
	
	return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
    //	UILabel *label = nil;
    //
    //	//create new view if no view is available for recycling
    //	if (view == nil)
    //	{
    //		view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] autorelease];
    //		label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
    //		label.backgroundColor = [UIColor clearColor];
    //		label.textAlignment = UITextAlignmentCenter;
    //		label.font = [label.font fontWithSize:50.0f];
    //		[view addSubview:label];
    //	}
    //	else
    //	{
    //		label = [[view subviews] lastObject];
    //	}
    //
    //    //set label
    //	label.text = (index == 0)? @"[": @"]";
    //
    //	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return wrap;
}


- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    return 0.3;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
}


- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel
{
    [self setSelectedwithIndex:carousel.currentItemIndex];
    
}


- (void)setSelectedwithIndex:(NSInteger)index
{
    if (self.lastSelected != -1)
    {
        [self img:[carousel itemViewAtIndex:self.lastSelected] setState:NO];
    }
    self.lastSelected = index;
    [self img:[carousel itemViewAtIndex:index] setState:YES];
    NSDictionary* companyInfo = [self.items objectAtIndex:index];
    self.labelCompanyName.text = [companyInfo objectForKey:@"name"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    if (self.items && [self.items count] > 0)
    {
        [self setSelectedwithIndex:self.carousel.currentItemIndex];
    }
    
    if (self.isAuthing)
    {
        SyncOperationManager* syncManager = [SyncOperationManager shareInstance];
        
        //    SyncMainViewController* vc = [[SyncMainViewController alloc]initWithNibName:@"SyncMainViewController" bundle:nil];
        
        //    [self.psViewController.rootViewController.view addSubview:vc.view];
        //    vc.view.frame =  CGRectMake(0, 0, 800, 600);
        if ([syncManager isAuthoried])
        {
            SyncProgressViewController* vc = [[SyncProgressViewController alloc]initWithNibName:@"SyncProgressViewController" bundle:nil];
            syncManager.processerDelege = vc;
            syncManager.resultDelege = self;
            //UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
            //nav.view.frame = CGRectMake(0, 0, 800, 600);
            //nav.navigationBarHidden = YES;
            //PopUpViewController* pop = [[PopUpViewController alloc]initWithNavContentViewController:nav];
            SyncPopUpViewController* pop = [[SyncPopUpViewController alloc]initWithContentViewController:vc];
            pop.popUpDeleage = self;
            [pop show:self.view andAnimated:YES];
            [syncManager doUpdate:nil];
            [pop show:self.view andAnimated:YES];
        }
    }
}

- (void)syncSuccess:(SyncOperationManager *)manager
{
    self.isSynced = YES;
    self.isAuthing = NO;
    [[DataAdapter shareInstance]resetDatabaseWithFile:[[[DataAdapter shareInstance]dbPath] stringByAppendingPathComponent:LOCAL_DB_FILE_NAME]];
}

- (void)syncProgressUpdate:(SyncOperationManager *)manager andProgress:(CGFloat)progress
{
}


- (void)viewDidHide:(PopUpViewController *)vc
{
    NSLog(@"viewDidHide enter");
    if (self.isSynced)
    {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"PageViewStoryBoard" bundle:nil];
        UIViewController* root = [storyBoard instantiateInitialViewController];
        //UIViewController* root = [[RootViewController alloc]init];
        [self.navigationController presentModalViewController:root animated:YES];
        self.isSynced = NO;
    }
}

- (UIImage*)imageWithName:(NSString*)name
{
    NSString* path = [[[DataAdapter shareInstance]path] stringByAppendingPathComponent:name];
    LCFileManager* fm = [LCFileManager shareInstance];
    if (![fm checkSourPath:path error:nil])
    {
        path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    }
    if (nil == path)
    {
        return [UIImage imageNamed:PRODUCT_PIC_DEFALUT_THUMB];
    }

    return [UIImage imageWithContentsOfFile:path];
}


@end
