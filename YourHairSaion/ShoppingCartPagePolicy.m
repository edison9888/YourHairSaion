//
//  ShoppingCartPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ShoppingCartPagePolicy.h"
#import "ShoppingCartPsViewController.h"
#import "ShoppingCartViewController.h"

@implementation ShoppingCartPagePolicy

- (NSString*)title
{
    return @"已购产品";
}

- (void)setFilter
{
    [[DataAdapter shareInstance]setFilterByTypeId:self.subType];
}

- (id)initWithSubType:(NSString *)subType
{
    self = [super init];
    if (self)
    {
        self.subType = STRING_FOR_SHOPPING_CART_FILTER;
    }
    return self;
}

- (BOOL)need2RefreshWhenAppear
{
    return YES;
}

- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase*)dvc andIndex:(NSInteger)index andRvc:(RootViewController*)rvc
{
    /*
    int recodeCount = [[DataAdapter shareInstance] count];
    int fromIndex = index / 2 * [self itemPerPage];
    int toIndex = fromIndex + [self itemPerPage] - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    NSLog(@"record count[%d], page count[%d], record from[%d], to[%d], index[%d]", recodeCount, [self calcPageCount], fromIndex, toIndex, index);
    ShoppingCartPsViewController* lvc= [[ShoppingCartPsViewController alloc]initProductViewControllerWithTitle:[self title] fromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
    lvc.rootViewController = rvc;
    lvc.pagePolicy = self;
*/
    ShoppingCartViewController* lvc = [[ShoppingCartViewController alloc]initWithNibName:@"ShoppingCartViewController" bundle:nil];
    lvc.rootViewController = rvc;
    lvc.detailViewController = dvc;
    lvc.pagePolicy = self;
    return lvc;
}

- (void)reloadData:(PsViewController *)pvc
{
    [pvc reloadData];
}

@end
