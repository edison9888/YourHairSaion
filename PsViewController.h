//
//  MapPsViewController.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-24.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"
#import "PSCollectionView.h"
#import "PsDataItem.h"
@class RootViewController;
@class PsDetailViewController;

@interface PsViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource>
@property (nonatomic, strong)RootViewController* rootViewController;

@property (nonatomic, strong) PsDetailViewController* detailViewController;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) int fromIndex;
@property (nonatomic, assign) int toIndex;


- (id)initProductViewControllerWithTitle:(NSString*)title fromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(PsDetailViewController*)detailViewController;
- (void)dataSourceDidLoad;
- (NSUInteger)indexInPage;

- (void)reloadData;
- (void)setRangWithFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
