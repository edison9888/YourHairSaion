//
//  MapPsViewController.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-24.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "MapPsViewController.h"
#import "MapPsItemView.h"
#import "OrganizationItem.h"
#import "DataAdapter.h"
#import "RootViewController.h"

@interface MapPsViewController ()

@end

@implementation MapPsViewController

- (void)loadDataSource {
    [self.items removeAllObjects];
    DataAdapter* dataAdapter = [DataAdapter shareInstance];
    for (int i = self.fromIndex; i <= self.toIndex; i++)
    {
        OrganizationItem* item = [[OrganizationItem alloc]initWithObject:dataAdapter.organizations[i]];
        [self.items addObject:item];
    }
    [self dataSourceDidLoad];
    
}
/*

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    MapPsItemView *v = (MapPsItemView *)[self.collectionView dequeueReusableView];
    if (!v) {
        v = [[MapPsItemView alloc] initWithFrame:CGRectZero];
    }
    [v fillViewWithObject:item];
    
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    id item = [self.items objectAtIndex:index];
    
    return [MapPsItemView heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    
    [self restoreSelected:collectionView];
    [view setBackgroundColor:selectedColor];
    self.lastSelectedIndex = index;
    //NGTabBarController* tarBarControllerRight =     rootview.viewControllers[1];
    //UINavigationController* nav1 = tarBarControllerRight.viewControllers[0];
    //nav1.title = is.productName;
    [self.detailViewController setOrgItem:[self.items objectAtIndex:index]];
    //[self.detailViewController.view drawRect:self.detailViewController.view.frame];
}
*/
@end
