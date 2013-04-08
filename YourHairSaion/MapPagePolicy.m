//
//  MapPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MapPagePolicy.h"
#import "OrgDetailViewController.h"
#import "MapViewController.h"


@implementation MapPagePolicy

- (BOOL)isProduct
{
    return NO;
}
- (UIViewController*)createRightVC
{
    return [[OrgDetailViewController alloc]init];
}
- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase*)dvc andIndex:(NSInteger)index andRvc:(RootViewController*)rvc
{
    MapViewController* mvc = [[MapViewController alloc]init];
    mvc.detailOnMap = (OrgDetailViewController*)dvc;
    return mvc;

}

- (void)loadData:(PsViewController *)pvc
{
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
    return 0;
}
- (NSString*)title
{
    return @"分店简介 - 地图";
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
        self.subType = MAP_SUBTYPE_MAP;
    }
    return self;
}

- (void)bindVcPair:(UIViewController *)rvc withLvc:(UIViewController *)lvc
{
    
}

- (NSInteger)itemPerPage
{
    return ITEMS_PER_PAGE_MAP;
}


@end
