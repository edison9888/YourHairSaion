//
//  ListMapPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ListMapPagePolicy.h"
#import "MapPsViewController.h"
#import "OrgDetailViewController.h"

@implementation ListMapPagePolicy

- (BOOL)isProduct
{
    return YES;
}
- (UIViewController*)createRightVC
{
    return [[OrgDetailViewController alloc]init];
}
- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase*)dvc andIndex:(NSInteger)index andRvc:(RootViewController*)rvc
{
    int recodeCount = [[DataAdapter shareInstance].organizations count];
    int fromIndex = index / 2 * [self itemPerPage];
    int toIndex = fromIndex + [self itemPerPage] - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    NSLog(@"record count[%d], page count[%d], record from[%d], to[%d], index[%d]", recodeCount, [self calcPageCount], fromIndex, toIndex, index);
    MapPsViewController* lvc= [[MapPsViewController alloc]initProductViewControllerWithTitle:[self title] fromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
    lvc.rootViewController = rvc;
    lvc.pagePolicy = self;

    return lvc;
}

- (void)loadData:(PsViewController *)pvc
{
    [pvc setPageCount:[self calcPageCount]];
}

- (NSString*)genKey4Index:(NSInteger)index
{
    return [NSString stringWithFormat:@"Map%@%d", self.subType, index];
}
- (void)setFilter
{
}

- (NSInteger)calcPageCount
{
    int itemCount = [[DataAdapter shareInstance].organizations count];
    int pageCount = itemCount / [self itemPerPage];
    pageCount = itemCount - (pageCount*[self itemPerPage]) > 0  ? pageCount+1 : pageCount;
    return pageCount;
}
- (NSString*)title
{
    return @"分店简介 - 列表";
}


- (BOOL)need2RefreshWhenAppear
{
    return NO;
}

- (void)refreshData
{
    
}

- (id)initWithSubType:(NSString *)subType
{
    self = [super init];
    if (self)
    {
        self.subType = MAP_SUBTYPE_LIST;
    }
    return self;
}


@end
