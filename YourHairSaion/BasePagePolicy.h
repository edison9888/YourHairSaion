//
//  BasePagePolicy.h
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAdapter.h"
@class RootViewController;
@class PsDetailViewControllerBase;
@class PsViewController;

@interface BasePagePolicy : NSObject


- (BOOL)isProduct;
- (NSString*)subType;
- (UIViewController*)createRightVC;
- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase*)dvc andIndex:(NSInteger)index andRvc:(RootViewController*)rvc;
- (NSString*)genKey4Index:(NSInteger)index;
- (void)setFilter;
- (void)setSubType:(NSString*)subType;
- (NSInteger)calcPageCount;
- (NSString*)title;
- (void)setIndex;
- (void)loadData:(PsViewController*)pvc;
- (id)initWithSubType:(NSString*)subType;
- (id)initWithRvc:(RootViewController*)rvc andSubType:(NSString*)subType;
- (BOOL)need2RefreshWhenAppear;
- (void)refreshData;
- (BOOL)isEqual:(BasePagePolicy*)object;
- (void)bindVcPair:(UIViewController*)rvc withLvc:(UIViewController*)lvc;
- (NSInteger)itemPerPage;
- (void)reloadData:(PsViewController*)pvc;
@end
