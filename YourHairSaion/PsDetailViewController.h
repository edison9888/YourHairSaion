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


@interface PsDetailViewController : PsDetailViewControllerBase <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *table;
@end
