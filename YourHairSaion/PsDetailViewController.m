//
//  PsDetailViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDetailViewController.h"
#import "PsDetailViewController.h"
#import "PsDataItem.h"
#import "PsViewController.h"
#import "DataAdapter.h"
#import "SyncOperationManager.h"
#import "TextInputPopViewController.h"
#import "SyncProgressViewController.h"
#import "SyncMainViewController.h"
#import "SyncPopUpViewController.h"
#import "RootViewController.h"
#import "L1Button.h"
#import "UIView+CornerAddition.h"
#import "DetailInDetailViewController.h"
#import "CMPopTipView.h"

typedef enum {
	NUMBER_OF_SECTIONS
} TableSections;



@interface PsDetailViewController ()
@property (nonatomic, strong)UIPopoverController* pc;
@property (strong, nonatomic)TextInputPopViewController* inputPvc;




@end

@implementation PsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"PsDetailViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"papes_right.png"]];
    //	UIImage *backgroundImage = [[UIImage imageNamed:@"paper_right.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:6];
	UIImageView *backgroundImageView = nil;//[[UIImageView alloc] initWithImage:backgroundImage];
	//backgroundImageView.frame = self.view.bounds;
	self.table.backgroundView = backgroundImageView;
    //self.orgItem = [[OrganizationItem alloc]initWithObject:[DataAdapter shareInstance].organizations[0]];
    //self.table.bounds = CGRectMake(20, 20, 200, 200);
    //self.table.center = self.view.center;
    self.scrollView.delegate = self;
    
    
    self.inputPvc = [[TextInputPopViewController alloc]initWithNibName:@"TextInputPopViewController" bundle:nil];
    [self.inputPvc setContentSizeForViewInPopover:self.inputPvc.view.bounds.size];
    self.inputPvc.rvc = self.psViewController.rootViewController;
    self.pc = [[UIPopoverController alloc]initWithContentViewController:self.inputPvc];
    self.inputPvc.pc = self.pc;
    self.labelPage.text = [NSString stringWithFormat:@"- PAGE %d -", [self indexInPage]+1];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 1;
    self.pageControl.hidesForSinglePage = YES;
}



//- (void)viewDidAppear:(BOOL)animated
//{
////    self.table.bounds = CGRectMake(0, 0, 340, 600);
////    self.table.center = self.view.center;
//}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.table = nil;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == kImage)
    //    {
    //        UITableViewCell* cell =  [self tableView:self.table cellForRowAtIndexPath:indexPath];
    //        if ([cell isKindOfClass:[ImageTableCell class]])
    //        {
    //            return [((ImageTableCell*)cell) height];
    //        }
    //    }
	return 20;
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString* kImageCellIdentifier = @"ImageCellIdentifier";
	static NSString *kOtherCellIdentifier = @"OtherCellIdentifier";
	
	NSString *workingCellIdentifier =nil;
    switch (indexPath.section)
    {
        default:
            workingCellIdentifier = kOtherCellIdentifier;
            break;
    }
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workingCellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:workingCellIdentifier];
	}
	
	switch (indexPath.section) {
        default:
			break;
	}
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.item == nil ? 0 : NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = 0;
	switch (section) {
		default:
			break;
	}
	return rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Accessors

- (void)setItem:(PsDataItem *)dataItem {
    [super setItem:dataItem];
	[self.table reloadData];
    for (UIView* view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    int pageCount = [dataItem imageCount];
    self.pageControl.numberOfPages = pageCount;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * pageCount, self.scrollView.frame.size.height);
    for (int i = 0; i < pageCount; i ++)
    {
        UIImageView* iv = [[UIImageView alloc]initWithImage:[dataItem imageAtIndex:i]];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        iv.frame = frame;
        [self.scrollView addSubview:iv];
    }
    
}


- (IBAction)onSearch:(id)sender
{
    //pc.popoverContentSize = inputPvc.view.bounds.size;//CGSizeMake(400, 400);
    
    [self.pc presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:self.btnSearch permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



- (void)onResetUserData:(id)sender
{
    [self.psViewController.rootViewController resetData:YES];
    [self updateShoppingCartNum];
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
}

- (void)updateShoppingCartNum
{
    NSUInteger buyCount = [[DataAdapter shareInstance]totalNumInShoppingCart];
    if (buyCount > 0)
    {
        [self.btnGoShoppingCart setCornerContent:[NSString stringWithFormat:@"%d", buyCount]];
    }
    else
    {
        [self.btnGoShoppingCart setCornerContent:nil];
    }
}


- (void)onGoShoppingCart:(id)sender
{
    if ([[DataAdapter shareInstance].productsToBuy count] <= 0 )
    {
        CMPopTipView* popTipView = [[CMPopTipView alloc] initWithMessage:@"亲还木有购买任何产品哦！"];
        popTipView.backgroundColor = [UIColor grayColor];
        popTipView.animation = YES;
        
        popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
        [popTipView presentPointingAtView:sender inView:self.view animated:YES];
    }
    else
    {
        [((L1Button*)self.psViewController.rootViewController.l1Btns.lastObject) sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateShoppingCartNum];

}

@end

