//
//  PsDetailViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PsDataItem.h"
#import "PsViewController.h"
#import "PsDetailViewControllerBase.h"
#import "ImageTableCell.h"
#import "DetailImageView.h"


@interface PsDetailViewController : PsDetailViewControllerBase <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *btnGoShoppingCart;
@property (nonatomic, retain) IBOutlet UIButton* btnSearch;
@property (nonatomic, strong)IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong)IBOutlet UIPageControl* pageControl;



@property (nonatomic, retain) IBOutlet UIImageView *imageBg;
@property (nonatomic, retain) IBOutlet UIImageView *ivDetailBg;

@property (nonatomic, retain) IBOutlet UILabel *labelPage;
@property (nonatomic, retain) IBOutlet UIView *viewTitle;



- (IBAction)onSearch:(id)sender;
- (IBAction)onSync:(id)sender;
- (IBAction)onGoShoppingCart:(id)sender;
- (IBAction)onResetUserData:(id)sender;
- (void)imgTouchInside:(id)sender;
@end
