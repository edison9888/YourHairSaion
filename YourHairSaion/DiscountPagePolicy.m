//
//  DiscountPagePolicy.m
//  YourHairSaion
//
//  Created by chen loman on 12-12-1.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DiscountPagePolicy.h"
#import "DiscountCardDetailViewController.h"
#import "DiscountPsViewController.h"

@implementation DiscountPagePolicy
- (UIViewController*)createRightVC
{
    return [[DiscountCardDetailViewController alloc] init];
}

- (UIViewController*)createLeftVCwithDetailVc:(PsDetailViewControllerBase *)dvc andIndex:(NSInteger)index andRvc:(RootViewController *)rvc
{
    int recodeCount = [[DataAdapter shareInstance].discountCards count];
    int fromIndex = index / 2 * [self itemPerPage];
    int toIndex = fromIndex + [self itemPerPage] - 1;
    toIndex = toIndex >= recodeCount ? recodeCount - 1 : toIndex;
    NSLog(@"record count[%d], page count[%d], record from[%d], to[%d], index[%d]", recodeCount, [self calcPageCount], fromIndex, toIndex, index);
    PsViewController* lvc = [[DiscountPsViewController alloc]initProductViewControllerWithTitle:[self title] fromIndex:fromIndex endIndex:toIndex withDetailViewController:dvc];
    lvc.rootViewController = rvc;
    lvc.pagePolicy = self;
    return lvc;
}

- (NSString*)title
{
    return @"VIP卡";
}

- (NSString*)genKey4Index:(NSInteger)index
{
    return [NSString stringWithFormat:@"Policy%d", index];
}

- (NSInteger)calcPageCount
{
    int itemCount = [[DataAdapter shareInstance].discountCards count];
    int pageCount = itemCount / [self itemPerPage];
    pageCount = itemCount - (pageCount*[self itemPerPage]) > 0  ? pageCount+1 : pageCount;
    return pageCount;
}

- (void)setFilter
{
}

- (BOOL)isProduct
{
    return NO;
}


- (NSInteger)itemPerPage
{
    return ITEMS_PER_PAGE_DISCOUNT_CARD;
}

@end
