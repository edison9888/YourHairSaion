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
#import "ImageTableCell.h"


@interface PsDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) PsDataItem *item;
@property (nonatomic, strong) PsViewController* psViewController;

- (NSUInteger)indexInPage;
@end
