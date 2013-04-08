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

#define TAG_PSVIEW_BASE 2000



@class RootViewController;
@class PsDetailViewControllerBase;
@class PsItemView;
@class BasePagePolicy;

@interface PsViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource>
@property (nonatomic, strong)RootViewController* rootViewController;

@property (nonatomic, strong) PsDetailViewControllerBase* detailViewController;
@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) int fromIndex;
@property (nonatomic, assign) int toIndex;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) BasePagePolicy* pagePolicy;



- (id)initProductViewControllerWithTitle:(NSString*)title fromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex withDetailViewController:(PsDetailViewControllerBase*)dvc;
- (void)dataSourceDidLoad;
- (NSUInteger)indexInPage;

- (void)reloadData;
- (void)setRangWithFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
- (void)setTitleStr:(NSString *)title;
- (PsItemView*)createNewItemViewWithIndex:(NSInteger)index;
- (void)restoreSelected:(PSCollectionView *)collectionView;
- (void)setCollectionViewColum;


@end
