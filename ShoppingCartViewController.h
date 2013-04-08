//
//  ShoppingCartViewController.h
//  YourHairSaion
//
//  Created by chen loman on 13-1-29.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartTableCell.h"
@class RootViewController;
@class PsDetailViewControllerBase;
@class PsItemView;
@class BasePagePolicy;


@interface ShoppingCartViewController : UIViewController<ShoppingCartTableCellDeleage>
@property (nonatomic, strong)IBOutlet UITableView* tableView;

@property (nonatomic, strong)RootViewController* rootViewController;

@property (nonatomic, strong) PsDetailViewControllerBase* detailViewController;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) BasePagePolicy* pagePolicy;

- (void)reloadData;
- (NSUInteger)indexInPage;

@end
